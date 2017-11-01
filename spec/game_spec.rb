require "game"
require "byebug"

RSpec.describe Game do
  let(:initial_lives) { 7 }
  let(:guess_word) { "powershop" }

  subject(:game) { described_class.new(lives_remaining: initial_lives, guess_word: guess_word) }

  it "creates a new game" do
    expect(game).not_to be_nil
  end

  describe '#start_game' do
    describe 'the initial game state' do
      it 'has no visible characters in the clue' do
        initial_state = game.start_game
        expect(initial_state.clue).to eq guess_word.chars.map { |c| nil }
      end
  
      it 'the player has not lost any lives' do
        initial_state = game.start_game
        expect(initial_state.lives_remaining).to eq initial_lives
      end
    end
  end


  describe "#make_guess!" do
    shared_examples_for "invalid_guesses" do
      it "changes nothing" do
        game_state = game.make_guess!(guess)
        expect { game.make_guess!(guess) }.not_to change { game_state.clue }
        expect { game.make_guess!(guess) }.not_to change { game_state.lives_remaining }
        expect { game.make_guess!(guess) }.not_to change { game_state.guesses}
        expect(game_state).not_to be_game_over
      end
    end

    context "when the guess is a number" do
      let(:guess) { "3" }

      include_examples "invalid_guesses"
    end

    context "when the guess is a special character" do
      let(:guess) { "_" }

      include_examples "invalid_guesses"
    end

    context "when the guess is an empty string" do
      let(:guess) { "" }

      include_examples "invalid_guesses"
    end

    context "when the guess contains only whitespace" do
      let(:guess) { " " }

      include_examples "invalid_guesses"
    end

    context "when the guess is greater than one letter long" do
      let(:guess) { "aa" }

      include_examples "invalid_guesses"
    end

    it "handles a correct guess" do
      game_state = game.make_guess!("p")

      expect { game.make_guess!("p") }.not_to change { game_state.lives_remaining }
      expect(game_state.clue).to eq ["p", nil, nil, nil, nil, nil, nil, nil, "p"]
      expect(game_state.guess_result).to eq :correct_guess
      expect(game_state.guesses).to eq ["p"]
      expect(game_state).not_to be_game_over
    end

    it "handles an incorrect guess" do
      game_state = game.make_guess!("v")

      expect(game_state.clue).to eq [nil] * 9
      expect(game_state.lives_remaining).to eq initial_lives - 1
      expect(game_state.guess_result).to eq :incorrect_guess
      expect(game_state.guesses).to eq ["v"]
      expect(game_state).not_to be_game_over
    end

    it "handles a duplicate guess" do
      game.make_guess!("w")
      game_state = game.make_guess!("w")

      expect(game_state.clue).to eq [nil, nil, "w", nil, nil, nil, nil, nil, nil]
      expect(game_state.lives_remaining).to eq initial_lives
      expect(game_state.guess_result).to eq :duplicate_guess
      expect(game_state.guesses).to eq ["w"]
      expect(game_state).not_to be_game_over
    end

    it "handles a guess that wins a game" do
      guesses = guess_word.chars.uniq
      guesses[0...-1].each do |c|
        game.make_guess!(c)
      end

      game_over_state = game.make_guess!(guesses[-1])

      expect(game_over_state.clue).to eq guess_word.chars
      expect(game_over_state.lives_remaining).to eq initial_lives
      expect(game_over_state.guess_result).to eq :correct_guess
      expect(game_over_state.guesses).to eq guesses
      expect(game_over_state).to be_won
      expect(game_over_state).not_to be_lost
      expect(game_over_state).to be_game_over
    end

    it "handles a guess that loses a game" do
      incorrect_guesses = ("a".."z").to_a - guess_word.chars
      incorrect_guesses = incorrect_guesses.take(initial_lives)

      incorrect_guesses[0...-1].each do |c|
        game.make_guess!(c)
      end

      game_over_state = game.make_guess!(incorrect_guesses.last)

      expect(game_over_state.clue).to eq guess_word.chars
      expect(game_over_state.lives_remaining).to eq 0
      expect(game_over_state.guess_result).to eq :incorrect_guess
      expect(game_over_state.guesses).to eq incorrect_guesses
      expect(game_over_state).not_to be_won
      expect(game_over_state).to be_lost
      expect(game_over_state).to be_game_over
    end
  end
end
