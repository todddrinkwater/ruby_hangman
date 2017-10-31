require "console_ui"
require "byebug"

RSpec.describe ConsoleUI do
  subject (:console_ui) { described_class.new }

  describe "#display_clue" do
    context "when game first starts" do
      it "returns a masked word" do
        new_game = console_ui.game
        clue = new_game.send(:word).chars.map! { |element| element = "_" }.join(" ")

        expect(console_ui.display_clue).to eq "Your clue: #{clue}"
      end
    end
  end

  describe "#display_guesses" do
    context "when the first guess is made" do
      guesses = ["a"]
      it "displays a single guess" do
        expect(console_ui.display_guesses(guesses)).to eq "Previous guesses: a"
      end
    end

    context "when a second unique guess is made" do
      guesses = ["a", "b"]
      it "displays a single guess" do
        expect(console_ui.display_guesses(guesses)).to eq "Previous guesses: a b"
      end
    end
  end

  describe "#display_guess_result" do
    context "when guess is correct" do
      it "informs user guess is correct in green" do
        expect(console_ui.display_guess_result(:correct_guess)).to eq "\e[32mCorrect\e[0m"
      end
    end

    context "when guess is incorrect" do
      it "informs user guess is incorrect in red" do
        expect(console_ui.display_guess_result(:incorrect_guess)).to eq "\e[31mIncorrect\e[0m"
      end
    end

    context "when guess is invalid" do
      it "informs user guess is invalid in yellow" do
        expect(console_ui.display_guess_result(:invalid_guess)).to eq "\e[33mInvalid guess. \n Guess must only contain a single letter.\e[0m"
      end
    end

    context "when guess has already been made" do
      it "informs user guess is has already been made in yellow" do
        expect(console_ui.display_guess_result(:duplicate_guess)).to eq "\e[33mGuess has already been made, guess again.\e[0m"
      end
    end
  end
end