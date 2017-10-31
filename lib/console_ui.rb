require_relative "./game"

class ConsoleUI

  attr_accessor :game, :word

  def initialize
    @word = ["horse", "dog", "flux", "rails"].sample
    @game = Game.new(lives_remaining: 7, guess_word: word)
  end
  
  def start_new_game
    new_game = game.start_game
    puts "Welcome to Hangman"
    puts display_clue
    puts "Lives remaining: #{new_game.lives_remaining}"
    
    display_progress(game.play_turn(guessed_letter)) until game.play_turn(guessed_letter).game_over?
    
    stored_letter = guessed_letter
  end
  
  def display_progress(turn)
    puts turn.guess_result
    puts turn.lives_remaining
    puts display_clue
    puts turn.guesses
  end
  
  def display_clue
    new_game = game.start_game
    place_holder = "_"
    clue = new_game.clue.map { |e| e == nil ? place_holder : e }
    "Your clue: #{clue.join(" ")}"
  end
  
  def ask_for_guess
    "Please make a guess:"
  end
  
  def guessed_letter
    gets.chomp
  end
end