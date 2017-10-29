class ConsoleUI
  
  def display_clue(clue)
    masked_word = clue.map { |element| element = "_" }
    "Clue: #{masked_word.join(" ")} \n"
  end
  
  def display_lives_remaining(lives_remaining)
    "Lives remaining: #{lives_remaining} \n"
  end
  
end