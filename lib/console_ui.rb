require_relative "./game"

class ConsoleUI

  attr_accessor :game, :word

  def initialize
    @word = ["horse", "dog", "flux", "rails"].sample
    @game = Game.new(lives_remaining: 7, guess_word: word)
  end
  
  def start_new_game
    new_game = game.start_game
    
    puts display_welcome_message
    puts display_clue
    puts "Lives remaining: #{new_game.lives_remaining}"
    
    play_turn
  end
  
  def play_turn
    loop do
      turn = game.play_turn(guessed_letter)
      if display_progress(turn) == true then break; end
    end
  end
  
  def display_welcome_message
    "Welcome to Hangman"
  end
  
  def display_progress(turn)
    puts turn.guess_result
    puts turn.lives_remaining
    puts display_clue
    puts display_guesses(turn.guesses)
    
    turn.game_over?
  end
  
  def display_clue
    new_game = game.start_game
    place_holder = "_"
    clue = new_game.clue.map { |e| e == nil ? place_holder : e }
    "Your clue: #{clue.join(" ")}"
  end
  
  def display_guesses(guesses)
    "Previous guesses: #{guesses.join(" ")}"
  end
  
  def ask_for_guess
    "Please make a guess:"
  end
  
  def guessed_letter
    gets.chomp
  end
end