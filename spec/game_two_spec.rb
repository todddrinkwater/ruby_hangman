require "game_two"
require "byebug"

RSpec.describe GameTwo do
  subject(:game) { described_class.new }
  
  it "creates a new game" do
    expect(game).not_to be_nil
  end

  describe '#clue' do
    context 'when no letters have been guessed' do
      it 'displays the clue' do
        expect(game.clue).to eq "_ _ _ _ _ _ _ _ _"
      end
    end

    context 'when one letter has been guessed' do
      it 'displays the clue with the guessed letters shown' do
        game.guess_letter("o")
        expect(game.clue).to eq "_ o _ _ _ _ _ o _"
      end
    end
    
    context 'when two letters have been guessed' do
      it 'displays the clue with the guessed letters shown' do
        game.guess_letter("o")
        game.guess_letter("w")
        expect(game.clue).to eq "_ o w _ _ _ _ o _"
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
        game.guess_letter("h")
        expect(game.clue).to eq "p o w e r s h o p"
      end
    end
  end
  
  describe '#guess_letter' do
    context 'when I guess a letter in the word' do
      it "added to the list of guesses" do
        game.guess_letter("p")
        expect(game.guesses).to eq ["p"]
      end
      it 'the letter appears in the clue' do
        game.guess_letter("p")
        expect(game.clue).to eq "p _ _ _ _ _ _ _ p"
      end
      it "does not remove a life"
    end
    
    context "when I guess a letter not in the word" do
      it "added to the list of guesses"
      it "informs the player the guess was incorrect"
      it "deducts a life"
    end
    
    context "when I guess a letter that has already been guessed" do
      it "is not added to the list of guesses"
      it "informs the player the letter is invalid"
      it "does not remove a life"
    end
  end
  
  # describe #guesses_already_made do

  # end
end
