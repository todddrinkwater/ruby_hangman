require 'byebug'

class GameTwo
  WORD = "powershop"

  attr_reader :guesses
  attr_accessor :lives_remaining
  
  def initialize
    @guesses = []
    @lives_remaining = 7
  end
  
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
    if guess.is_a?(Integer)
      :number_guess
    elsif guess.strip.empty?
      :empty_guess
    elsif guess.length != 1
      :invalid_length_guess
    elsif guesses.include?(guess)
      :letter_invalid
    elsif WORD.include?(guess)
      guesses << guess
    else
      guesses << guess
      #TODO: Why does this have to be an instance var or using self??
      self.lives_remaining -= 1
      :incorrect
    end
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