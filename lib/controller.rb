require_relative 'state'
require_relative 'input_output'
require_relative 'validate'
require 'byebug'

#TODO: try to get rid of instance variables, by passing around local vars into methods.
#TODO: try to reduce duplication.
#TODO: move methods into appropriate class once theme presents itself.
#TODO: Bug - allows win if admin_input == 0

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
    welcome_message
    admin_input = @input_output.admin_input
    until get_admin_input(admin_input) === true do
      admin_input = @input_output.admin_input
    end
    create_status_display(admin_input)
    display_lives_remaining
    display_letters_remaining
    until game_won? || game_lost? do
      take_single_turn(admin_input)
    end
  end

  def take_single_turn(admin_input)
    user_input = @input_output.user_input
    until player_input_valid?(user_input) == true && letter_not_guessed_yet?(user_input) do
      user_input = @input_output.user_input
    end
    is_guess_correct(admin_input, user_input)
    create_status_display(admin_input, user_input)
    display_correct_guesses
    display_incorrect_guesses
    display_lives_remaining
    display_letters_remaining
    puts "- - - - - - - - - - - "
  end


  def new_game
    input_output.welcome_message
  end

  def welcome_message
    @input_output.admin_input_message
  end


  def get_admin_input(admin_input)
    @validate.validate_admin_input(admin_input)
    @admin_input_submitted = true
  end

  def create_status_display(admin_input, user_input = nil)
    admin_input_arr = admin_input.chars #up to here
    if user_input == nil
      admin_input.length.times { @state.word_display.push("_") }
      display_str = @state.word_display.join(' ')
      print "#{display_str}\n"
    else
      @state.word_display = admin_input_arr.map { |letter|    @state.correct_guesses_arr.include?(letter) ? letter : "_" }
      display_str = @state.word_display.join(' ')
      print "#{display_str}\n"
    end
  end

  def display_lives_remaining
    @lives_remaining = @state.lives_remaining - @state.incorrect_guesses_arr.length
    puts "--> 😩 Lives remaining: #{@lives_remaining}"
  end

  def display_letters_remaining
    @letters_remaining = @state.word_display.count("_")
    puts "--> 😁 Letters remaining: #{@letters_remaining}\n\n"
  end

  def display_correct_guesses
    correct_guesses_display = @state.correct_guesses_arr.join(' ')
    puts "Correct guesses made: #{correct_guesses_display}\n"
  end

  def display_incorrect_guesses
    incorrect_guesses_display = @state.incorrect_guesses_arr.join(' ')
    puts "Incorrect guesses made: #{incorrect_guesses_display}\n"
  end


  def player_input_valid?(user_input)
    @validate.validate_player_input(user_input)
  end

  def is_guess_correct(guess_word, user_guess)
    guess_word = guess_word.chars
    if guess_word.include?(user_guess)
      @state.correct_guesses_arr.push(user_guess)
      puts "Correct!"
    else
      @state.incorrect_guesses_arr.push(user_guess)
      puts "Unlucky!"
    end
  end

  def letter_not_guessed_yet?(user_input)
    if @state.correct_guesses_arr.include?(user_input) || @state.incorrect_guesses_arr.include?(user_input)
      puts "You've already guessed this letter!"
      return false
    end
    true
  end

  def game_won?
    if @letters_remaining < 1
      puts "You win! 😎"
      true
    else
      false
    end
  end

  def game_lost?
    if @lives_remaining < 1
      puts "You lose. 💀 👻"
      true
    else
      false
    end
  end
end
