RSpec.describe Game do
  describe "new Game" do

    subject(:game) { described_class.new }

    describe '.new' do
      it "creates an an instance of the Game class" do
        expect(game).to be_an_instance_of(Game)
      end

      it "creates new state class" do
        expect(game.state).to be_an_instance_of(State)
      end

      it "creates new validate class" do
        expect(game.validate).to be_an_instance_of(Validate)
      end

      it "creates new input_output classs" do
        expect(game.input_output).to be_an_instance_of(InputOutput)
      end
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
