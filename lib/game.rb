require_relative 'state'
require_relative 'input_output'
require_relative 'validate'
require 'byebug'

class Game
  attr_reader :input_output, :state, :validate
  attr_accessor :guess_word

  def initialize(input_output: InputOutput.new)
    @input_output = input_output
    @state = State.new
    @validate = Validate.new
  end

  def game_start
    input_output.show_welcome_message
    input_output.get_guess_word
    guess_word = input_output.enter_guess_word #TODO: Refactor this and line below later.
    guess_word = ask_for_admin_input(guess_word) until validate.input_type_ok?(guess_word) && validate.admin_input_length_ok?(guess_word)
    guess_word.downcase!
    create_progress_display(guess_word, state.total_lives)
    take_single_turn(guess_word, state.total_lives) until game_over?(state)
    game_over_message
  end

  def take_single_turn(guess_word, lives_remaining)
    input_output.user_input_prompt
    user_input = input_output.user_input
    user_input = ask_for_player_input(guess_word, user_input) until letter_ok?(guess_word, user_input) && validate.player_input_length_ok?(user_input)
    state.update_guesses(guess_correct?(guess_word, user_input), user_input)
    create_progress_display(guess_word, state.lives_remaining)
  end
  
  
  def ask_for_player_input(guess_word, user_input)
    input_output.invalid_letter if !letter_ok?(guess_word, user_input)
    input_output.only_single_letter if !validate.player_input_length_ok?(user_input)
    user_input = input_output.user_input
  end
  
  def ask_for_admin_input(guess_word)
    input_output.only_letters if !validate.input_type_ok?(guess_word)
    input_output.more_letters if !validate.admin_input_length_ok?(guess_word)
    guess_word = input_output.enter_guess_word
  end

  def create_progress_display(guess_word, total_lives)
    input_output.show_player_progress(state.player_progress(guess_word))
    input_output.display_incorrect_guesses(state.incorrect_guesses)
    input_output.display_lives_remaining(total_lives)
    input_output.display_letters_remaining(state.letters_remaining)
  end

  def guess_correct?(guess_word, user_guess)
    guess_word.chars.include?(user_guess)
  end

  def already_guessed?(user_input)
    state.correct_guesses.include?(user_input) || state.incorrect_guesses.include?(user_input)
  end

  def game_over?(state)
    state.letters_remaining < 1 || state.lives_remaining < 1
  end

  def game_over_message
    if state.letters_remaining < 1
      input_output.game_won
    elsif state.lives_remaining < 1
      input_output.game_lost
    end
  end

  def letter_ok?(guess_word, user_input)
    validate.input_type_ok?(user_input) && !already_guessed?(user_input)
  end

end
