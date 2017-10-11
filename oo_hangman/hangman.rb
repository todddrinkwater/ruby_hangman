#big bag of state
require './state'
require './input_output'
require './process_game_state'



# controller is purely an orchestrator
class Controller
  def initialize(input_output: InputOutput.new)
    @input_output = input_output
    @state = State.new
    @process_game_state = ProcessGameState.new
  end

  def new_game
    @input_output.welcome_message
  end

# TODO: Create a method to run game loop

  def input_guess_word
    @admin_input = @input_output.admin_input
    @process_game_state.validate_admin_input(@admin_input)
  end

  # def display_game_status
  #   puts "{Lives: #{@state.lives_remaining}}"
  #   @state.letters_remaining = @admin_input.length
  #   puts @state.letters_remaining
  # end


end
