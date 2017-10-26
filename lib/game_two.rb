require 'byebug'

class GameTwo
  attr_accessor :guesses
  attr_reader :lives_remaining

  def initialize(lives_remaining:, guess_word:)
    @guesses = []
    @lives_remaining = lives_remaining
    @word = guess_word
  end
  
  # When a game begins:
    # A clue is displayed to the console.
    # The amount of lives remaining for the player is displayed.

  def clue
    masked_word = @word.chars
    masked_word.map! { |letter| guesses.include?(letter) ? letter : nil }
  end

  def guess_letter(guess)
    guess = guess.to_s
    guess_is_valid = guess.length == 1 && guess.scan(/[^a-zA-Z]/).empty?

    return :invalid_guess unless guess_is_valid

    if guesses.include?(guess)
      :duplicate_guess
    elsif @word.include?(guess)
      guesses << guess
    else
      guesses << guess
      @lives_remaining -= 1
      :incorrect_guess
    end
  end

  def game_over?
    lost? || won?
  end

  def won?
    guessed_word = clue.join
    (guessed_word == @word) && (@lives_remaining > 1) #neccessary??
  end

  def lost?
    @lives_remaining < 1
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