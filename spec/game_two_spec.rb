require "game_two"
require "byebug"

RSpec.describe GameTwo do
  subject(:game) { described_class.new }
  
  it "creates a new game" do
    expect(game).not_to be_nil
  end

  describe '#clue' do
    # First
    context 'when no letters have been guessed' do
      it 'displays the clue' do
        expect(game.clue).to eq "_ _ _ _ _ _ _ _ _"
      end
    end

    # third
    context 'when one letter has been guessed' do
      it 'displays the clue with the guessed letters shown' do
        expect(game.guess_letter("o")).to eq "_ o _ _ _ _ _ o _"
      end
    end
    
    context 'when two letters have been guessed' do
      it 'displays the clue with the guessed letters shown' do
        game.guess_letter("o")
        expect(game.guess_letter("w")).to eq "_ o w _ _ _ _ o _"
      end
    end
    
    context 'displays all letters when guessed' do
      it 'displays the clue with the guessed letters shown' do
        game.guess_letter("p")
        game.guess_letter("o")
        game.guess_letter("w")
        game.guess_letter("e")
        game.guess_letter("r")
        game.guess_letter("s")
        expect(game.guess_letter("h")).to eq "p o w e r s h o p"
      end
    end
  end
  
  describe '#guess_letter' do
    # Second
    context 'when I guess a letter in the word' do
      it 'the letter appears in the clue' do
        expect(game.guess_letter("p")).to eq "p _ _ _ _ _ _ _ p"
      end
    end
  end
end
