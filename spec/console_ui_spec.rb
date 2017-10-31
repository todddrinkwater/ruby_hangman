require "console_ui"
require "byebug"

RSpec.describe ConsoleUI do
  subject (:console_ui) { described_class.new }
  
  context "when initalizing a new game" do
    it "chooses a set number of lives" do
      expect(console_ui.game.start_game.lives_remaining).to eq 7
    end
  end
    
  describe "#display_clue" do
    context "when no letters are guessed" do
      it "returns a string of underscores" do
        console_ui.game.guess_word = "dog"
        byebug
        expect(console_ui.display_clue).to eq "Your clue: _ _ _"
      end
    end
  end
end