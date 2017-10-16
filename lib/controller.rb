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
  attr_accessor :guess_word

  def initialize(input_output: InputOutput.new)
    @input_output = input_output
    @state = State.new
    @validate = Validate.new
  end

#add whitespace to make more readable
  def game_flow
    new_game
    welcome_message
    guess_word = input_output.admin_input until validate.validate_admin_input(guess_word)

    #TODO: refactor this to a seperate method
    input_output.show_player_progress(state.player_progress(guess_word))
    input_output.display_lives_remaining(state.total_lives)
    input_output.display_letters_remaining(state.letters_remaining)

    #TODO: Line 40 into one method that can be called with single argument.
    until game_over?(state) do
      take_single_turn(guess_word, state.total_lives)
    end
    game_over_message
  end

  def take_single_turn(guess_word, lives_remaining)
    user_input = input_output.user_input
    #TODO: Refactor into method, because of same arguments etc.
    until validate.validate_player_input(user_input) && letter_not_guessed_yet?(user_input) do
      user_input = input_output.user_input
    end
    #TODO: Get rid of "is", "as" etc. and assign is_guess_correct to var above.
    update_guesses(guess_correct?(guess_word, user_input), user_input)
    #TODO: Refactor (as in method above) into a single method.
    input_output.show_player_progress(state.player_progress(guess_word))
    input_output.display_correct_guesses(state.correct_guesses)
    input_output.display_incorrect_guesses(state.incorrect_guesses)
    input_output.display_lives_remaining(state.lives_remaining)
    input_output.display_letters_remaining(state.letters_remaining)
    puts "- - - - - - - - - - - "
  end


  def new_game #change name!
    input_output.welcome_message
  end

  def welcome_message #change also!
    input_output.admin_input_message
  end

  def admin_input_valid?(admin_input)
    validate.validate_admin_input(admin_input)
  end


  def update_guesses(correct, user_guess)
    if correct
      state.correct_guesses.push(user_guess)
    else
      state.incorrect_guesses.push(user_guess)
    end
  end


  def guess_correct?(guess_word, user_guess)
    if guess_word.chars.include?(user_guess)
      true
    else
      false
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

  def game_over?(state)
    if state.letters_remaining < 1
      true
    elsif state.lives_remaining < 1
      true
    end
  end

  def game_over_message
    if state.letters_remaining < 1
      input_output.game_won
    elsif state.lives_remaining < 1
      input_output.game_lost
    end
  end

end
