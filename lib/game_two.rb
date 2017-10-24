class GameTwo
  WORD = "powershop"

  attr_reader :guesses, :clue
  
  def initialize
    @guesses = []
    @clue = []
  end
  
  def clue
    if guesses.empty?
       guess_word = []
       WORD.length.times { guess_word << "_" }
       guess_word.join(" ")
    else
      guess_word = WORD.chars
      guess_word.map! { |letter| guesses.include?(letter) ? letter : "_" }
      guess_word.join(" ")
    end
  end

  def guess_letter(guess)
    guesses << guess
    clue
  end
  
end

# Until lives remaining is 0 or all letters guessed
  # Display current state of the game
  # Get a guess from player
  # If guess has already been made, tell the player
  # Elsif guess is in word, then show letter in word
  # Elsif guess is not in word, take a life
# Tell player if they've won or lost


#Map through each letter of POWERSHOP
#If guess matches a letter from the word array then push it to the clue var, otherwise push "_"