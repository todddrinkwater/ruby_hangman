class GameTwo
  WORD = "powershop"

  attr_reader :guesses
  
  def initialize
    @guesses = []
  end
  
  def clue
    if guesses.empty?
      guess_word = []
      WORD.length.times { guess_word << "_" }
    else
      guess_word = WORD.chars
      guess_word.map! { |letter| guesses.include?(letter) ? letter : "_" }
    end
    guess_word.join(" ")
  end

  def guess_letter(guess)
    guesses << guess
  end
  
  # def guess_already_made?(guess)
  #   WORD.chars.include?(guess)
  # end
  
end

# Until lives remaining is 0 or all letters guessed
  # Display current state of the game
  # Get a guess from player
  # If guess has already been made, tell the player
  # Elsif guess is in word, then show letter in word
  # Elsif guess is not in word, take a life
# Tell player if they've won or lost

# Can only create a method if required by public interface or it is repeated for the third time.