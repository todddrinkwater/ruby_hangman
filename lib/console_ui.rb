class ConsoleUI
  
  attr_reader :game

  def initialize
    @game = GameTwo.new(lives_remaining: 7)
  end
  
  def start_game
    puts "Clue: #{game.clue}"
    puts "Lives remaining: #{game.lives_remaining}"
  end
  
  def play_turn
    puts "Take a guess:"
    guess = gets.chomp
    puts "Clue: #{game.clue}"
    puts "Lives remaining: #{game.lives_remaining}"
  
  end
end