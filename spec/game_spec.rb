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
    it "returns the masked word and lives remaining to the console" do
      initial_state = game.start_game

      expect(initial_state.clue).to eq guess_word.chars.map { |c| nil }
      expect(initial_state.lives_remaining).to eq initial_lives
    end
  end

  describe "#play_turn" do

    context "handles invalid guesses" do
      it "when the guess is a number" do
        game_state = game.play_turn("3")

        expect(game_state.clue).to eq guess_word.chars.map { |c| nil }
        expect(game_state.lives_remaining).to eq initial_lives
        expect(game_state.guess_result).to eq :invalid_guess
        expect(game_state).not_to be_game_over
        expect(game_state.guesses).to eq []
      end

      it "when the guess is a special character" do
        game_state = game.play_turn("_")

        expect(game_state.clue).to eq guess_word.chars.map { |c| nil }
        expect(game_state.lives_remaining).to eq initial_lives
        expect(game_state.guess_result).to eq :invalid_guess
        expect(game_state).not_to be_game_over
        expect(game_state.guesses).to eq []
      end

      it "when the guess is an empty string" do
        game_state = game.play_turn("")

        expect(game_state.clue).to eq guess_word.chars.map { |c| nil }
        expect(game_state.lives_remaining).to eq initial_lives
        expect(game_state.guess_result).to eq :invalid_guess
        expect(game_state).not_to be_game_over
        expect(game_state.guesses).to eq []
      end

      it "when the guess contains only whitespace" do
        game_state = game.play_turn(" ")

        expect(game_state.clue).to eq guess_word.chars.map { |c| nil }
        expect(game_state.lives_remaining).to eq initial_lives
        expect(game_state.guess_result).to eq :invalid_guess
        expect(game_state).not_to be_game_over
        expect(game_state.guesses).to eq []
      end

      it "when the guess is greater than one letter long" do
        game_state = game.play_turn("aa")

        expect(game_state.clue).to eq guess_word.chars.map { |c| nil }
        expect(game_state.lives_remaining).to eq initial_lives
        expect(game_state.guess_result).to eq :invalid_guess
        expect(game_state).not_to be_game_over
        expect(game_state.guesses).to eq []
      end
    end

    it "handles a correct guess" do
      game_state = game.play_turn("p")

      expect(game_state.clue).to eq ["p", nil, nil, nil, nil, nil, nil, nil, "p"]
      expect(game_state.lives_remaining).to eq initial_lives
      expect(game_state.guess_result).to eq :correct_guess
      expect(game_state.guesses).to eq ["p"]
      expect(game_state).not_to be_game_over
    end

    it "handles an incorrect guess" do
      game_state = game.play_turn("v")

      expect(game_state.clue).to eq [nil] * 9
      expect(game_state.lives_remaining).to eq initial_lives - 1
      expect(game_state.guess_result).to eq :incorrect_guess
      expect(game_state.guesses).to eq ["v"]
      expect(game_state).not_to be_game_over
    end

    it "handles a duplicate guess" do
      game_state = game.play_turn("w")
      game_state = game.play_turn("w")

      expect(game_state.clue).to eq [nil, nil, "w", nil, nil, nil, nil, nil, nil]
      expect(game_state.lives_remaining).to eq initial_lives
      expect(game_state.guess_result).to eq :duplicate_guess
      expect(game_state.guesses).to eq ["w"]
      expect(game_state).not_to be_game_over
    end

    it "handles a guess that wins a game" do
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
      expect(game_over_state).to be_game_over
    end

    it "handles a guess that loses a game" do
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
      expect(game_over_state).to be_game_over
    end
  end
end
