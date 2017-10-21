class InputOutput
  def show_welcome_message
    puts "WELCOME to HANGMAN. \n"
  end

  def get_guess_word
    puts "Please enter the word to guess:"
  end

  def enter_guess_word
    gets.chomp
  end

  def user_input_prompt
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

  def only_single_letter
    puts "Please enter ONLY a single letter."
  end

  def line_break
    puts "- - - - - - - - - - - "
  end
end
