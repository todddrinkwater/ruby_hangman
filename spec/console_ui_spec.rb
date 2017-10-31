require "console_ui"
require "byebug"

RSpec.describe ConsoleUI do
  subject (:console_ui) { described_class.new }
  
  describe "#display_welcome_message" do
    it "creates welcome message at start of game" do
      expect(console_ui.display_welcome_message).to eq "Welcome to Hangman"
    end
  end
  
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
end