RSpec.describe Validate do

  describe "Validate Class" do
    
    subject(:validate) { described_class.new }

    describe '#guess_word_accepted?' do

      it "returns false when string is empty" do
        expect(validate.guess_word_accepted?("")).to eql false
      end

      it "returns false when string contains numbers" do
        expect(validate.guess_word_accepted?("h3ngman")).to eql false
        expect(validate.guess_word_accepted?("3")).to eql false
      end
      
      it "returns false when string contains a space" do
        expect(validate.guess_word_accepted?("hang man")).to eql false
      end
      
      it "returns true regardless of character casing" do
        expect(validate.guess_word_accepted?("hAnGmaN")).to eql true
      end
      
    end

    describe '#player_guess_accepted?' do

      it "returns false when string length is less than 0" do
        expect(validate.player_guess_accepted?("")).to eql false
      end

      it "returns false when string length is greater than 1" do
        expect(validate.player_guess_accepted?("ha")).to eql false
      end
      
      it "returns true on single letter input" do
        expect(validate.player_guess_accepted?("h")).to eql true
      end
      
      it "returns false when a number is used" do
        expect(validate.player_guess_accepted?("3")).to eql false
      end
      
    end
 end

end
