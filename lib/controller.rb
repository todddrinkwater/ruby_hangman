require_relative 'state'
require_relative 'input_output'
require_relative 'validate'
require 'byebug'

#TODO: try to get rid of instance variables, by passing around local vars into methods.
#TODO: try to reduce duplication.
#TODO: move methods into appropriate class once theme presents itself.

#TODO: Remove duplication lines 26-29, while loops.

#2: is_guess_correct - worth breaking up? how would I go about it?
#3: game_flow hard to read
#4: Messages being refactored but still being called from within functions. A good idea?


class Controller
  attr_reader :input_output, :state, :validate
  attr_accessor :admin_input

  def initialize(input_output: InputOutput.new)
    @input_output = input_output
    @state = State.new
    @validate = Validate.new
  end

#add whitespace to make more readable
  def game_flow
    new_game
    welcome_message

    admin_input = input_output.admin_input until admin_input_valid?(admin_input)

    state.lives_remaining
    input_output.show_player_progress(state.player_progress(admin_input))
    letters_remaining
    input_output.display_lives_remaining(state.total_lives)
    input_output.display_letters_remaining(letters_remaining)

    until game_won?(letters_remaining) || game_lost?(state.lives_remaining) do
      take_single_turn(admin_input, state.total_lives)
    end
  end

  def take_single_turn(admin_input, lives_remaining)
    user_input = input_output.user_input
    until player_input_valid?(user_input) && letter_not_guessed_yet?(user_input) do
      user_input = input_output.user_input
    end

    update_guesses(is_guess_correct?(admin_input, user_input), user_input)

    input_output.show_player_progress(state.player_progress(admin_input))
    letters_remaining
    input_output.display_correct_guesses(state.correct_guesses)
    input_output.display_incorrect_guesses(state.incorrect_guesses)
    input_output.display_lives_remaining(state.lives_remaining)
    input_output.display_letters_remaining(letters_remaining)
    puts "- - - - - - - - - - - "
  end


  def new_game
    input_output.welcome_message
  end

  def welcome_message
    input_output.admin_input_message
  end

  def admin_input_valid?(admin_input)
    validate.validate_admin_input(admin_input)
  end


 #TODO: move to State,
  # def lives_remaining(state)
  #   state.total_lives - state.incorrect_guesses.length
  # end

#TODO: Have a look into word_display logic. Move to state.
  def letters_remaining
    state.word_display.count("_")
  end


  def player_input_valid?(user_input)
    validate.validate_player_input(user_input)
  end

 # if is_guess_correct? then update_guesses
 # input_output.guess_correct
 # input_output.guess_incorrect
  def update_guesses(bool, user_guess)
    if bool
      state.correct_guesses.push(user_guess)
    else
      state.incorrect_guesses.push(user_guess)
    end
  end


  def is_guess_correct?(guess_word, user_guess)
    if guess_word.chars.include?(user_guess)
      true
    else
      false
    end
  end


#TODO: Refactor into two methods and look at renaming to suit what it does.
  def is_guess_correct(guess_word, user_guess)
    if guess_word.chars.include?(user_guess)
      state.correct_guesses.push(user_guess)
      input_output.guess_correct
    else
      state.incorrect_guesses.push(user_guess)
      input_output.guess_incorrect
    end
  end

#TODO: Rename: ? Signals a boolean value
  def letter_not_guessed_yet?(user_input)
    if state.correct_guesses.include?(user_input) || state.incorrect_guesses.include?(user_input)
      input_output.already_guessed
      return false
    end
    true
  end

  def game_won?(letters_remaining)
    if letters_remaining < 1
      puts "You win! 😎"
      true
    else
      false
    end
  end

  def game_lost?(lives_remaining)
    if lives_remaining < 1
      puts "You lose. 💀 👻"
      true
    else
      false
    end
  end

end
