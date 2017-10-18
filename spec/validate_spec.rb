RSpec.describe Validate do

  describe "Validate Class" do

    before :each do
      @validate = Validate.new
    end

    describe '.input_length?' do

      it "returns false when string is empty" do
        @validate.admin_input_length?("") == false
      end

      it "returns true when string length > 1" do
        @validate.admin_input_length?("a") == true
      end

    end

    describe '.admin_input_type_ok?' do

      it "returns true when only letters (case-insensitive) are parsed" do
        @validate.input_type_ok?("hAngMan") == true
      end

      it "returns false when a integer is parsed" do
        @validate.input_type_ok?("h4ngman") == false
      end

      it "returns false when white space is parsed" do
        @validate.input_type_ok?("h angman") == false
      end

      it "returns false when a non_word character is parsed" do
        @validate.input_type_ok?("h_angman") == false
      end

    end

    describe '.player_input_length?' do

      it "returns true when length == 1" do
        @validate.player_input_length?("h") == true
      end

      it "returns false when length != 1" do
        @validate.player_input_length?("ha") == true
        @validate.player_input_length?("") == true
      end

    end

 end

end
