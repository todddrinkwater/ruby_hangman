#big bag of state
require './state'
require './input_output'
require './process_game_state'


  # function bark() {
  #   return "woof"
  # }
  #
  # var dog = bark
  #
  # var dog = bark()


  # admin_start => do import & set @admin_input (eg "pirate")
  # @admin_input => "pirate"


  # attr_reader :cat
  #
  # def initialize
  #   @cat = Cat.new
  # end
  #
  # def method_name
  #   cat = Dog.new
  # end

# controller is purely an orchestrator
class Controller
  attr_reader :input_output
  attr_accessor :admin_input

  def initialize(input_output: InputOutput.new)
    @input_output = input_output
    @state = State.new
    @validate = Validate.new
  end

  def game_flow
    new_game
    admin_start
    until get_admin_input === true do
      admin_start
    end
  end

  def new_game
    input_output.welcome_message
  end

  def admin_start
    @input_output.admin_input_message
    @admin_input = input_output.admin_input
  end

# TODO: Create a method to run game loop

  def get_admin_input
    @validate.validate_admin_input(@admin_input)
  end

  def create_status_display
    @admin_input = admin_input
    word_array = @admin_input.chars
    print word_array
    print admin_input.length
    admin_input.length.times { @state.word_display.push("_") }
    print @state.word_display
  end

  # def display_game_status
  #   puts "{Lives: #{@state.lives_remaining}}"
  #   @state.letters_remaining = @admin_input.length
  #   puts @state.letters_remaining
  # end


end
