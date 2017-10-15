
#TODO: find out what is wrong with spec helper

RSpec.describe Controller do
  describe "new controller" do

    before :each do
     @controller = Controller.new
    end

    it "creates an an instance of the controller class" do
      expect(@controller).to be_an_instance_of(Controller)
    end

    it "creates new state" do
      expect(@controller.state).to be_an_instance_of(State)
    end

    it "creates a welcome message" do
      expect(@controller.new_game) === "WELCOME to HANGMAN. \n"
    end

    it "successfully grabs number of lives_remaining" do
      expect(@controller.display_lives_remaining) == 7
    end
  end
end



# Reference
# . --> class method
# # --> instance method

# describe '.authenticate' do
# describe '#admin?' do

# creates an instance of Controller before each test.
# before :each do
#  @controller = Controller.new
# end
