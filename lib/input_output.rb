class InputOutput
  def welcome_message
    puts "WELCOME to HANGMAN. \n"
  end

  def admin_input_message
    puts "Please enter your choosen word:"
  end

  def admin_input
    gets.chomp
  end

  def admin_input_message
    puts "Please enter your guess word:"
  end

  def user_input_message
    puts "Please guess a letter:"
  end

  def user_input
    gets.chomp
  end

  def display_lives_remaining(lives_remaining)
    puts "--> 😩 Lives remaining: #{lives_remaining}"
  end

  def display_letters_remaining(letters_remaining)
    puts "--> 😁 Letters remaining: #{letters_remaining}\n\n"
  end

  def display_correct_guesses(correct_guesses_arr)
    puts "Correct guesses made: #{correct_guesses_arr.join(' ')}\n"
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

  def invalid_letter
    puts "Please enter a letter that is VALID and not already guessed."
  end

  def more_letters
    puts "Please enter at least one letter."
  end

  def only_letters
    puts "Please enter only letter characters (incl. no spaces).\n"
  end

  def game_won
    puts "You win! 😎"
  end

  def game_lost
    puts "You lose. 💀 👻"
  end

  def only_letters
    puts "Please enter only letter characters (incl. no spaces)\n"
  end

  def line_break
    puts "- - - - - - - - - - - "
  end
end
