RSpec.describe Validate do
  describe "Validate Class" do
    before :each do
      @validate = Validate.new
    end

    describe '#validate_admin_input' do
      it "returns false when a integer is parsed" do
        @validate.validate_admin_input("t0dd") == false
      end

      it "returns true when only letters are parsed" do
        @validate.validate_admin_input("todd") == true
      end

      it "returns false when only white space is parsed" do
        @validate.validate_admin_input("t odd") == false
      end

  end

 end

end
