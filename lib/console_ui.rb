class ConsoleUI
  
  def display_clue(clue)
    masked_word = clue.map { |element| element == nil ? element = "_" : element }
    "Clue: #{masked_word.join(" ")} \n"
  end
  
  def display_lives_remaining(lives_remaining)
    "Lives remaining: #{lives_remaining} \n"
  end
  
  def display_guess_result(guess)
    case guess
    when :correct_guess
      "Correct guess \n"
    when :incorrect_guess
      "Incorrect guess \n"
    when :duplicate_guess
      "Letter already guessed \n"
    when :invalid_guess
      "Type of guess invalid. \n A guess must only contain a single letter value."
    end
  end
  
  def ask_for_guess
    "Take a guess:"
  end
  
  def player_guess
    gets.chomp
  end
end