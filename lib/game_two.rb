require 'byebug'

class GameTwo
  WORD = "powershop"

  attr_accessor :lives_remaining, :guesses
  def initialize
    @guesses = []
    @lives_remaining = 7
  end

  # def play_turn
  #   clue
  #   guess_letter
  # end

  def clue
    if guesses.empty?
      masked_word = []
      WORD.length.times { masked_word << "_" }
    else
      masked_word = WORD.chars
      masked_word.map! { |letter| guesses.include?(letter) ? letter : "_" }
    end
    masked_word.join(" ")
  end

  def guess_letter(guess)
    guess = guess.to_s
    guess_is_valid = guess.length == 1 && guess.scan(/[^a-zA-Z]/).empty?
    
    if !guess_is_valid
      return :invalid_guess
    end

    if guess_is_valid
      if guesses.include?(guess)
        :duplicate_guess
      elsif WORD.include?(guess)
        guesses << guess
      else
        guesses << guess
        @lives_remaining -= 1
        :incorrect_guess
      end
    end
  end

  def over?
    won? || lost?
  end

  def won?
    clue.scan(/[^a-zA-Z ]/).empty?
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
# Check if game is over?
  # Game over - Happens if someone has guessed all letters or runs out of lives.
    # Game won if user has guessed all letters, lives greater than 0
    # Game lost if user has not guessed all letters and lives less than 1
  # Game continues when... User still has lives and letters have not all been guessed.
  