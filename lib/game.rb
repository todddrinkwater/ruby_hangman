require_relative './game_state'

class Game

  def initialize(lives_remaining:, guess_word:)
    @guesses = []
    @lives_remaining = lives_remaining
    @word = guess_word
  end

  def start_game
    GameState.new(clue, lives_remaining)
  end

  def make_guess!(guess)
    guess_result = guess_letter(guess)
    ui_clue
    GameState.new(ui_clue, lives_remaining, guess_result, guesses.dup, won?, lost?, game_over?)
  end

  private

  attr_reader :guesses, :lives_remaining, :word
  
  def ui_clue
    ui_clue = game_over? ? word.chars : clue
  end

  def clue
    word.chars.map { |letter|  guessed_letter?(letter) ? letter : nil }
  end

  def guessed_letter?(letter)
    guesses.include?(letter)
  end

  def guess_letter(guess)
    guess_is_valid = /^[a-zA-Z]$/.match(guess)

    return :invalid_guess unless guess_is_valid
    return :duplicate_guess if guessed_letter?(guess)

    guesses << guess

    if word.include?(guess)
      :correct_guess
    else
      @lives_remaining -= 1
      :incorrect_guess
    end
  end

  def game_over?
    lost? || won?
  end

  def won?
    !lost? && word_guessed?
  end

  def lost?
    lives_remaining < 1
  end

  def word_guessed?
    clue.join == word
  end
end