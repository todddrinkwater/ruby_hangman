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
    
    context 'when all letters when guessed' do
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
end


# next set of tests
#Validation
  # Guess input length
  # Guess input type
  
#Player won or lost?
  #
