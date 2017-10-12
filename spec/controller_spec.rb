
#TODO: find out what is wrong with spec helper

RSpec.describe Controller do
  describe "new controller" do
    it "creates new state" do
      controller = Controller.new
      expect(controller.state).to be_an_instance_of(State)
    end

    it "creates a welcome to Hangman message" do
      controller = Controller.new
      expect(controller.new_game) == "WELCOME to HANGMAN, MANNNNNN \n - - - - - - - - - - - - -"
    end

    it "successfully grabs number of lives_remaining" do
      controller = Controller.new
      expect(controller.display_lives_remaining) == 7
    end
  end


end
