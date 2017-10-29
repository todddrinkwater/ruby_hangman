require 'console_ui'

RSpec.describe ConsoleUI do
  subject (:console_ui) { described_class.new }
  let(:clue) { %w[D O G] }
  
  describe '#display_clue' do
    
    context 'when no letters have been guessed' do
      it 'should return a clue of the word with letters hidden' do
        expect(console_ui.display_clue(clue)).to eq "Clue: _ _ _ \n"
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
  
end