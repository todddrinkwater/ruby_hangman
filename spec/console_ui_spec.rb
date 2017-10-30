require 'console_ui'

RSpec.describe ConsoleUI do
  subject (:console_ui) { described_class.new }

  describe '#display_clue' do
    context 'when no letters have been guessed' do
      let(:clue) { [nil, nil, nil] }

      it 'should return a clue of the word with letters hidden' do
        expect(console_ui.display_clue(clue)).to eq "Clue: _ _ _ \n"
      end
    end

    context "when some, but not all letters are guessed" do
      let(:clue) { ["D", nil, "G"] }

      it 'should return clue showing only letters guessed' do
        expect(console_ui.display_clue(clue)).to eq "Clue: D _ G \n"
      end
    end

    context "when all letters have been correctly guessed" do
      let(:clue) { ["D", "O", "G"] }

      it "should reveal all letters" do
        expect(console_ui.display_clue(clue)).to eq "Clue: D O G \n"
      end
    end
  end

  describe '#display_lives_remaining' do
    context 'when game starts' do
      let(:lives_remaining) { 7 }

      it 'should display correct number of lives remaining' do
        expect(console_ui.display_lives_remaining(lives_remaining)).to eq "Lives remaining: 7 \n"
      end
    end
  end

  describe '#display_guess_result' do
    context 'guess is correct' do
      let(:guess) { :correct_guess }

      it "informs user guess is correct" do
        expect(console_ui.display_guess_result(guess)).to eq "Correct guess \n"
      end
    end

    context 'guess is incorrect' do
      let(:guess) { :incorrect_guess }

      it "informs user guess is incorrect" do
        expect(console_ui.display_guess_result(guess)).to eq "Incorrect guess \n"
      end
    end

    context 'guess is has already been made' do
      let(:guess) { :duplicate_guess }

      it "informs user letter has already been guessed" do
        expect(console_ui.display_guess_result(guess)).to eq "Letter already guessed \n"
      end
    end

    context 'guess input is on invalid type' do
      let(:guess) { :invalid_guess }

      it "informs user guess type was invalid" do
        expect(console_ui.display_guess_result(guess)).to eq "Type of guess invalid. \n A guess must only contain a single letter value."
      end
    end
  end
  
  describe '#display_game_state' do
    end
  end
end