class InputOutput
  def welcome_message
    puts "WELCOME to HANGMAN. \n"
  end

  def guess_word_prompt
    puts "Please enter the word to guess:"
  end

  def get_guess_word
    gets.chomp
  end

  def player_guess_prompt
    puts "Please guess a letter:"
  end

  def get_player_guess
    gets.chomp
  end

  def display_lives_remaining(lives_remaining)
    puts "--> 😩 Lives remaining: #{lives_remaining}"
  end

  def display_letters_remaining(letters_remaining)
    puts "--> 😁 Letters remaining: #{letters_remaining}\n\n"
  end

  def display_incorrect_guesses(incorrect_guesses_arr)
    puts "Incorrect guesses made: #{incorrect_guesses_arr.join(' ')}\n"
  end

  def show_player_progress(word_display)
    print "#{word_display.join(' ')}\n"
  end

  def guess_correct
    puts "Correct!"
  end

  def guess_incorrect
    puts "Unlucky!"
  end

  def invalid_guess_word_message
    puts "Guess word must have at least one letter, no spaces, and no numbers."
  end
  
  def already_guessed_message
    "Letter already_guessed. Please guess again:"
  end

  def game_won_message
    puts "You win! 😎"
  end

  def game_lost_message
    puts "You lose. 💀 👻"
  end

  def invalid_player_guess_message
    puts "Invalid guess: Guess must contain a SINGLE letter with no spaces or numbers."
  end

  def line_break
    puts "- - - - - - - - - - - "
  end
end
