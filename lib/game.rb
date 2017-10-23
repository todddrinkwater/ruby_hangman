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
    input_output.welcome_message
    input_output.guess_word_prompt
    guess_word = input_output.retrieve_guess_word
    guess_word = check_guess_word_loop(guess_word)
    create_progress_display(guess_word, state.total_lives)
    take_single_turn(guess_word, state.total_lives) until game_over?(state)
    game_over_message
  end
  
  private
  
  def take_single_turn(guess_word, lives_remaining)
    input_output.player_guess_prompt
    player_guess = input_output.get_player_guess
    
    until guess_valid?(player_guess) do
      input_output.invalid_player_guess_message if !validate.player_guess_accepted?(player_guess)
      input_output.already_guessed_message if letter_already_guessed?(player_guess)
      player_guess = input_output.get_player_guess
    end
    
    state.update_guesses_made(guess_correct?(guess_word, player_guess), player_guess)
    create_progress_display(guess_word, state.lives_remaining)
  end

  def guess_valid?(player_guess)
    validate.player_guess_accepted?(player_guess) && !letter_already_guessed?(player_guess)
  end
  
  def check_guess_word_loop(guess_word)
    until validate.guess_word_accepted?(guess_word) do
      input_output.invalid_guess_word_message
      guess_word = input_output.get_guess_word
    end
    guess_word.downcase!
  end

  def create_progress_display(guess_word, total_lives)
    input_output.show_player_progress(state.player_progress(guess_word))
    input_output.display_incorrect_guesses(state.incorrect_guesses)
    input_output.display_lives_remaining(total_lives)
    input_output.display_letters_remaining(state.letters_remaining)
  end

  def guess_correct?(guess_word, player_guess)
    guess_word.chars.include?(player_guess)
  end

  def letter_already_guessed?(player_guess)
    state.correct_guesses.include?(player_guess) || state.incorrect_guesses.include?(player_guess)
  end

  def game_over?(state)
    state.letters_remaining < 1 || state.lives_remaining < 1
  end

  def game_over_message
    if state.letters_remaining < 1
      input_output.game_won_message
    elsif state.lives_remaining < 1
      input_output.game_lost_message
    end
  end
  
  def guess_word_accepted?(guess_word)
    validate.input_type_ok?(guess_word) && validate.guess_word_length_ok?(guess_word)
  end
end
