require_relative "./game"

class ConsoleUI

  attr_reader :game

  def initialize
    word = ["horse", "dog", "flux", "rails"].sample
    @game = Game.new(lives_remaining: 7, guess_word: word)
  end

  def start_new_game
    new_game = game.start_game

    puts "Welcome to Hangman"
    puts clue_message(new_game.clue)
    puts lives_remaining_message(new_game.lives_remaining)

    play_turn
  end

  private

  def play_turn
    loop do
      print "\n#{ask_for_guess}"
      state = game.play_turn(guessed_letter)
      display_game_state(state)
      break if state.game_over?
    end
  end

  def display_game_state(state)
    puts display_guess_result(state.guess_result)
    puts clue_message(game.start_game.clue)
    puts guesses_message(state.guesses)
    puts lives_remaining_message(state.lives_remaining)
    puts ""

    puts "You win!" if state.won?
    puts "You lose!" if state.lost?
  end

  def display_guess_result(result)
    case result
      when :correct_guess
        green("Correct")
      when :incorrect_guess
        red("Incorrect")
      when :invalid_guess
        yellow("Invalid guess. \n Guess must only contain a single letter.")
      when :duplicate_guess
        yellow("Guess has already been made, guess again.")
    end
  end

  def lives_remaining_message(lives)
    "Lives remaining: #{lives}"
  end

  def clue_message(clue)
    place_holder = "_"
    clue = clue.map { |e| e == nil ? place_holder : e }
    "Your clue: #{clue.join(" ")}"
  end

  def guesses_message(guesses)
    "Previous guesses: #{guesses.join(" ")}"
  end

  def ask_for_guess
    "Please make a guess: "
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