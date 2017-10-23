RSpec.describe Validate do

  describe "Validate Class" do

    before :each do #TODO: reformat to how Neil showed.
      @validate = Validate.new
    end

    describe '#guess_word_accepted?' do

      it "returns false when string is empty" do
        @validate.guess_word_accepted?("") == false
      end

      it "returns false when string contains numbers" do
        @validate.guess_word_accepted?("h3ngman") == false
      end
      
      it "returns false when string contains a space" do
        @validate.guess_word_accepted?("hang man") == false
      end
      
      it "returns true regardless of character casing" do
        @validate.guess_word_accepted?("hAnGmaN")
      end
      
      
    end

 end

end
