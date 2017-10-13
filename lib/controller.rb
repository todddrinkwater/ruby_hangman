require_relative 'state'
require_relative 'input_output'
require_relative 'validate'

# controller is purely an orchestrator
class Controller
  attr_reader :input_output, :state, :validate
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
    create_status_display
    display_lives_remaining
    display_letters_remaining
    until game_won? || game_lost? do
      take_single_turn
    end
  end

  def take_single_turn
    show_player_input_message
    until player_input_valid? == true do
      show_player_input_message
    end
    guess_correct?
    create_status_display
    display_lives_remaining
    display_letters_remaining
  end


  def new_game
    input_output.welcome_message
  end

  def admin_start
    @input_output.admin_input_message
    @admin_input = input_output.admin_input
  end


  def get_admin_input
    @validate.validate_admin_input(@admin_input)
    @admin_input_submitted = true
  end

  def create_status_display
    @admin_input = admin_input
    @admin_input_arr = @admin_input.chars
    if @user_input == nil
      admin_input.length.times { @state.word_display.push("_") }
      display_str = @state.word_display.join(' ')
      print "#{display_str}\n"
    else
      @state.word_display = @admin_input_arr.map { |letter| @state.correct_guesses_arr.include?(letter) ? letter : "_" }
      display_str = @state.word_display.join(' ')
      print "#{display_str}\n"
    end
  end

  def display_lives_remaining
    @lives_remaining = @state.lives_remaining - @state.incorrect_guesses_arr.length
    puts "--> Lives remaining: #{@lives_remaining}"
  end

  def display_letters_remaining
    @letters_remaining = @state.word_display.count("_")
    puts "--> Letters remaining: #{@letters_remaining}\n\n"
  end

  def show_player_input_message
    @user_input = @input_output.user_input
  end

  def player_input_valid?
    @validate.validate_player_input(@user_input)
  end

  def guess_correct?
    @admin_input_arr.include?(@user_input) ? @state.correct_guesses_arr.push(@user_input) : @state.incorrect_guesses_arr.push(@user_input)
  end

  def game_won?
    if @letters_remaining < 1
      puts "You win!"
      true
    else
      false
    end
  end

  def game_lost?
    if @lives_remaining < 1
      puts "You lose."
      true
    else
      false
    end
  end
end
