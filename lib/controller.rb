require_relative 'state'
require_relative 'input_output'
require_relative 'validate'
require 'byebug'

class Controller
  attr_reader :input_output, :state, :validate
  attr_accessor :guess_word

  def initialize(input_output: InputOutput.new)
    @input_output = input_output
    @state = State.new
    @validate = Validate.new
  end

  def game_flow
    input_output.welcome_message
    input_output.admin_input_message
    guess_word = input_output.admin_input

    until validate.input_length(guess_word) do
      input_output.more_letters
      guess_word = input_output.admin_input
    end

    until validate.input_type(guess_word) && validate.input_length(guess_word) do
      input_output.only_letters
      guess_word = input_output.admin_input
    end

    guess_word.downcase!

    create_display(guess_word, state.total_lives)

    until game_over?(state) do
      take_single_turn(guess_word, state.total_lives)
    end

    game_over_message
  end

  def take_single_turn(guess_word, lives_remaining)
    input_output.user_input_message

    until validate.player_input_length(user_input) do
      input_output.only_single_letter
      user_input = input_output.user_input
    end

    until letter_ok?(guess_word, user_input) && validate.player_input_length(user_input) do
      input_output.invalid_letter
      user_input = input_output.user_input;
    end

    state.update_guesses(guess_correct?(guess_word, user_input), user_input)

    create_display(guess_word, state.lives_remaining)
  end

  def create_display(guess_word, total_lives)
    input_output.show_player_progress(state.player_progress(guess_word))
    input_output.display_correct_guesses(state.correct_guesses)
    input_output.display_incorrect_guesses(state.incorrect_guesses)
    input_output.display_lives_remaining(total_lives)
    input_output.display_letters_remaining(state.letters_remaining)
  end

  def admin_input_valid?(admin_input)
    validate.validate_admin_input(admin_input)
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
    validate.input_type(user_input) && !already_guessed?(user_input)
  end

end
