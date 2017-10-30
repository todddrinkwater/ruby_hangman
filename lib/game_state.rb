class GameState
  attr_reader :clue, :lives_remaining, :guess_result, :guesses
  
  def initialize(clue, lives_remaining, guess_result = nil, guesses = [], won = false, lost = false)
    @clue = clue
    @lives_remaining = lives_remaining
    @guess_result = guess_result
    @guesses = guesses
    @won = won
    @lost = lost
  end
  
  def won?
    @won
  end
  
  def lost?
    @lost
  end
end