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
    puts display_lives_remaining(new_game.lives_remaining)
    
    play_turn
  end

  def play_turn
    loop do
      puts ask_for_guess
      turn = game.play_turn(guessed_letter)
      break if display_game_state(turn) == true
    end
  end

  def display_game_state(turn) #TODO: Two resposibilities, seperate
    puts display_guess_result(turn.guess_result)
    puts display_lives_remaining(turn.lives_remaining)
    puts display_clue
    puts display_guesses(turn.guesses)
    puts ""
    puts "You win!" if turn.won?
    puts "You lose!" if turn.lost?
    turn.game_over?
  end

  def display_guess_result(result)
    case result
      when :correct_guess
        return green("Correct")
      when :incorrect_guess
        return red("Incorrect")
      when :invalid_guess
        return yellow("Invalid guess. \n Guess must only contain a single letter.")
      when :duplicate_guess
        return yellow("Guess has already been made, guess again.")
    end
  end

  def display_lives_remaining(lives)
    "Lives remaining: #{lives}"
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
  
  def colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

  def red(text)
    colorize(text, 31)
  end
  
  def green(text)
    colorize(text, 32)
  end
  
  def yellow(text)
    colorize(text, 33)
  end
  
end