def admin_input
  print "ADMIN: Please enter your choosen word:"
  hangman_word = gets.chomp
  letters_remaining = hangman_word.length
  return hangman_word
end

def check_input_type(word)
  #also check string length is greater than 0
  regex_comparison = /[\d\s_\W]+/
  type_check = word.scan(regex_comparison)

  if type_check.length < 1 then word.downcase!
  else
    print "Word must only contain letters with no spacing. Please try again."
    admin_input
  end
end

def user_guess
  puts "Guess a letter!"
  guessed_letter = gets.chomp
  regex_comparison = /[\d\s_\W]/
  type_check = guessed_letter.scan(regex_comparison)
  puts type_check
  if (guessed_letter.length > 1) || (guessed_letter.length <= 0)
    puts "Please enter only a single letter."
    user_guess
  elsif type_check.length > 0
    puts "Please use only letters."
    user_guess
  else
    $guesses_array.push(guessed_letter)
    return guessed_letter
  end
end

def includes_letter?(word, guessed_letter)
  word_array = word.split('')
  if word_array.include?(guessed_letter)
    puts "Bullseye!"
  elsif word_array.include?(guessed_letter) == false
    puts "Sorry, you guessed wrong."
    $lives_remaining -= 1
    puts ". ."
    puts " ^"
  end
end

def display_guess_word(admin_word)
  word_display = []
  word_array = admin_word.chars # check that param is safe to use.

  admin_word_length = admin_word.length
  admin_word_length.times { word_display.push("_") }

  word_display = word_array.map { |letter| $guesses_array.include?(letter) ? letter : "_"}

  # word_array.each_index do |admin_index|
  #   $guesses_array.each_index do |guesses_index|
  #     if $guesses_array[guesses_index] == word_array[admin_index]
  #       word_display[admin_index] = word_array[admin_index]
  #     end
  #   end
  #   word_display
  # end
  
  $letters_remaining = word_display.count("_")
  print "GUESS WORD: #{word_display.join(" ")}\n"
end

def check_game_status
  if ($letters_remaining > 0) && ($lives_remaining > 0)
    puts "Lives remaining: #{$lives_remaining}"
    puts "Letters remaining: #{$letters_remaining}"
    puts "- - - - - - - - - - - - - - - "
    game_time_logic
  end
  if $letters_remaining < 1
    puts "Lifesaver. You win!"
    puts "Play again? Enter YES or NO"
    play_again = gets.chomp
    if play_again == "YES"
      run_hangman
    else
      return "BYE!"
    end
  end
  if $lives_remaining < 1
    puts "YOU LOSE."
    puts "Play again? Y or N?"
    play_again = gets.chomp
    if play_again == "yes" then run_hangman
    else puts "BYE!"
    end
  end
end

def game_time_logic
  guessed_letter = user_guess
  includes_letter?($hangman_guess_word, guessed_letter)
  print "Letters guessed: #{$guesses_array}\n"
  display_guess_word($hangman_guess_word)
  check_game_status
end

def run_hangman
  $guesses_array = [] #global vars not secure
  $lives_remaining = 7
  puts "Welcome to HANGMAN, mannnnn."
  $hangman_guess_word = admin_input
  $letters_remaining = $hangman_guess_word.length
  check_input_type($hangman_guess_word)
  game_time_logic
end

run_hangman
