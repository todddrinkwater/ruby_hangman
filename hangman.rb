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

def user_guess(guesses_array)
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
    guesses_array.push(guessed_letter)
    return guessed_letter
  end
end

def includes_letter?(word, guessed_letter, letters_remaining, lives_remaining, guesses_array)
  word_array = word.split('')
  if word_array.include?(guessed_letter)
    puts "Bullseye!"
    letters_remaining -= 1
  elsif word_array.include?(guessed_letter) == false
    puts "Sorry, you guessed wrong."
    lives_remaining -= 1
    puts "LIVES REMAINING: #{lives_remaining}"
    puts ". ."
    puts " ^"
  end
end

def display_guess_word(admin_word, guesses_array)
  # admin_word = "hangman"
  word_display = []
  # guesses_array = ["h", "a"]
  word_array = admin_word.split('') # check that param is safe to use.

  admin_word_length = admin_word.length
  admin_word_length.times { word_display.push("_") }

  word_array.each_index do |admin_index|
    guesses_array.each_index do |guesses_index|
      if guesses_array[guesses_index] == word_array[admin_index]
        word_display[admin_index] = word_array[admin_index]
      end
    end
  end

  print word_display
end

def run_hangman
  guesses_array = []
  lives_remaining = 7
  letters_remaining = 1
  puts "Welcome to HANGMAN, mannnnn."
  hangman_guess_word = admin_input
  check_input_type(hangman_guess_word)
  guessed_letter = user_guess(guesses_array)
  includes_letter?(hangman_guess_word, guessed_letter, letters_remaining, lives_remaining, guesses_array)
  print guesses_array
  display_guess_word(hangman_guess_word, guesses_array)
end

run_hangman
