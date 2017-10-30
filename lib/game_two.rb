require_relative './game_state'

class GameTwo

  def initialize(lives_remaining:, guess_word:)
    @guesses = []
    @lives_remaining = lives_remaining
    @word = guess_word
  end

  def start_game
    GameState.new(clue, lives_remaining)
  end

  def play_turn(guess)
    guess_result = guess_letter(guess)
    game_over? ? ui_clue = word.chars : ui_clue = clue
    GameState.new(ui_clue, lives_remaining, guess_result, guesses.dup, won?, lost?, game_over?)
  end

  private
  
  attr_reader :guesses, :lives_remaining, :word

  def clue
    masked_word = word.chars
    masked_word.map! { |letter|  guessed_letter?(letter) ? letter : nil }
  end
  
  def guessed_letter?(letter)
    guesses.include?(letter)
  end

  def guess_letter(guess)
    guess = guess.to_s
    guess_is_valid = guess.length == 1 && guess.scan(/[^a-zA-Z]/).empty?

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

# Until lives remaining is 0 or all letters guessed
  # Display current state of the game X
  # Get a guess from player
  # If guess has already been made, tell the player X
  # Elsif guess is in word, then show letter in word X
  # Elsif guess is not in word, take a life X
# Tell player if they've won or lost

# Can only create a method if required by public interface or it is repeated for the third time.

#Checking the status of the game
# Check if game is over? X
  # Game over - Happens if someone has guessed all letters or runs out of lives. X
    # Game won if user has guessed all letters, lives greater than 0 X
    # Game lost if user has not guessed all letters and lives less than 1 X
  # Game continues when... User still has lives and letters have not all been guessed.
  
# Can a player still make a guess if lost?
# Has a player won if they have guessed the word but their lives are at zero.