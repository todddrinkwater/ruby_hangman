require "game_two"
require "byebug"

RSpec.describe GameTwo do
  let(:initial_lives) { 7 }
  let(:guess_word) { "powershop" }
  
  subject(:game) { described_class.new(lives_remaining: initial_lives, guess_word: guess_word) }

  it "creates a new game" do
    expect(game).not_to be_nil
  end
  
  describe '#start_game' do
    it "returns the masked word and lives remaining to the console" do
      initial_state = game.start_game
      
      expect(initial_state.clue).to eq guess_word.chars.map { |c| nil }
      expect(initial_state.lives_remaining).to eq initial_lives
    end
  end
  
  describe "#play_turn" do
    
    it "when the guess is invalid" do
      game_state = game.play_turn("3")
      
      expect(game_state.clue).to eq guess_word.chars.map { |c| nil }
      expect(game_state.lives_remaining).to eq initial_lives
      expect(game_state.guess_result).to eq :invalid_guess
    end
    
    it "when the guess is correct" do
      game_state = game.play_turn("p")
      
      expect(game_state.clue).to eq ["p", nil, nil, nil, nil, nil, nil, nil, "p"]
      expect(game_state.lives_remaining).to eq initial_lives
      expect(game_state.guess_result).to eq :correct_guess
      expect(game_state.guesses).to eq ["p"]
    end
    
    it "when the guess is incorrect" do
      game_state = game.play_turn("v")
      
      expect(game_state.clue).to eq [nil] * 9
      expect(game_state.lives_remaining).to eq initial_lives - 1
      expect(game_state.guess_result).to eq :incorrect_guess
      expect(game_state.guesses).to eq ["v"]
    end
    
    it "when the guess is a duplicate" do
      game_state = game.play_turn("w")
      game_state = game.play_turn("w")
      
      expect(game_state.clue).to eq [nil, nil, "w", nil, nil, nil, nil, nil, nil]
      expect(game_state.lives_remaining).to eq initial_lives
      expect(game_state.guess_result).to eq :duplicate_guess
      expect(game.guesses).to eq ["w"]
    end
    
    it "when a guess wins a game" do
      guesses = guess_word.chars.uniq
      guesses[0...-1].each do |c|
        game.play_turn(c)
      end

      game_over_state = game.play_turn(guesses[-1])
      
      expect(game_over_state.clue).to eq guess_word.chars
      expect(game_over_state.lives_remaining).to eq initial_lives
      expect(game_over_state.guess_result).to eq :correct_guess
      expect(game_over_state.guesses).to eq guesses
      expect(game_over_state).to be_won
      expect(game_over_state).not_to be_lost
    end
    
    it "when a guess loses a game" do
      incorrect_guesses = ("a".."z").to_a - guess_word.chars
      incorrect_guesses = incorrect_guesses.take(initial_lives)
      
      incorrect_guesses[0...-1].each do |c|
        game.play_turn(c)
      end
      
      game_over_state = game.play_turn(incorrect_guesses.last)
      
      expect(game_over_state.clue).to eq guess_word.chars
      expect(game_over_state.lives_remaining).to eq 0
      expect(game_over_state.guess_result).to eq :incorrect_guess
      expect(game_over_state.guesses).to eq incorrect_guesses
      expect(game_over_state).not_to be_won
      expect(game_over_state).to be_lost
    end
  end
  

  describe '#clue' do
    context 'when no letters have been guessed' do
      it 'returns array of nil values' do
        expect(game.clue).to eq [nil] * 9
      end
    end

    context 'when one letter has been guessed' do
      it 'creates array that includes the correct guessed letters in correct order' do
        game.guesses = ["o"]
        expect(game.clue).to eq [nil, "o", nil, nil, nil, nil, nil, "o", nil]
      end
    end

    context 'when two letters have been guessed' do
      it 'creates array with the guessed letters shown in correct order' do
        game.guesses = %w[o w]
        expect(game.clue).to eq [nil, "o", "w", nil, nil, nil, nil, "o", nil]
      end
    end

    context 'when all the letters are guessed' do
      let(:word) { "powershop" }
      before { game.guesses = word.chars.uniq }

      it 'creates array cosisting of all letters' do
        expect(game.clue).to eq %w[p o w e r s h o p]
      end
    end
  end

  describe '#guess_letter' do
    context 'when I guess a letter in the word' do
      it "added to the list of guesses" do
        game.guess_letter("p")
        expect(game.guesses).to eq ["p"]
      end
      it "does not remove a life" do
        game.guess_letter("p")
        expect(game.lives_remaining).to eq 7
      end
    end

    context "when I guess a letter not in the word" do
      
      it "is adds the letter to the list of guesses" do
        game.guess_letter("b")
        expect(game.guesses).to eq ["b"]
      end

      it "informs the player the guess was incorrect" do
        expect(game.guess_letter("b")).to eq :incorrect_guess
      end

      it "deducts a life" do
        expect{game.guess_letter("b")}.to change{game.lives_remaining}.by -1
      end
    end

    context "when I guess a letter that has already been guessed" do
      let(:guess) { "p" }
      subject(:guess_letter) { game.guess_letter(guess) }

      before { game.guess_letter(guess) }

      it "is not added to the list of guesses" do
        guess_letter
        expect(game.guesses).to eq [guess]
      end

      it "informs the caller the guess has already been used" do
        expect(guess_letter).to eq :duplicate_guess
      end

      it "does not remove a life" do
        expect{guess_letter}.not_to change{game.lives_remaining}
      end
    end

    context "when the guess is not a letter" do
      context "the guess a number" do
        let(:guess) { 3 }

        it "informs that guess is invalid" do
          expect(game.guess_letter(guess)).to eq :invalid_guess
        end
      end

      context "when the guess contains a special character" do
        it "informs that guess is a special character" do
          expect(game.guess_letter("_")).to eq :invalid_guess
          expect(game.guess_letter("*")).to eq :invalid_guess
        end
      end

      context "the guess is empty" do
        context "guess is empty string" do
          let(:guess) { "" }

          it "informs that guess is invalid" do
            expect(game.guess_letter(guess)).to eq :invalid_guess
          end
        end

        context "the guess contains only whitespace" do
          let(:guess) { " " }

          it "informs that guess is invalid" do
            expect(game.guess_letter(guess)).to eq :invalid_guess
          end
        end
      end

      context "the guess is not one letter" do
        let(:guess) {"aa"}

        it "informs that guess is invalid" do
          expect(game.guess_letter(guess)).to eq :invalid_guess
        end
      end
    end
  end

  describe "#game_over?" do
    context "no lives remaining" do
      let(:initial_lives) { 0 }

      it "returns true" do
        expect(game.game_over?).to eq true
      end
    end

    context "all letters have been correctly guessed" do
      before { game.guesses = %w[p o w e r s h o p] }

      it "returns true" do
        expect(game.game_over?).to eq true
      end
    end
  end

  describe "#won?" do
    context "letters have all been guessed" do
      before { game.guesses = %w[p o w e r s h o p] }

      it "returns true" do
        expect(game.won?).to eq true
      end
    end

    context "letters have not all been guessed" do
      it "returns false" do
        expect(game.won?).to eq false
      end
    end

  end

  describe "#lost?" do
    context "lives remaining is zero" do
      let(:initial_lives) { 0 }

      it "returns true" do
        expect(game.lost?).to eq true
      end
    end
    
    context "lives remaining less than zero" do
      let(:initial_lives) { -1 }

      it "returns true" do
        expect(game.lost?).to eq true
      end
    end

    context "lives remaining is greater than zero" do
      let(:initial_lives) { 1 }

      it "returns false" do
        expect(game.lost?).to eq false
      end
    end
  end
end
