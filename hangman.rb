guesses_array = []

def admin_input
  print "ADMIN: Please enter your choosen word:"
  hangman_word = gets.chomp
  return hangman_word
end

def check_input_type(word)
  #also check string length is greater than 0
  regex_comparison = /[\d\s_\W]+/
  type_check = word.scan(regex_comparison)

  if type_check.length < 1 then word.downcase!
  else print "Word must only contain letters with no spacing. Please try again."
  end

  return word
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
    return guessed_letter
  end
end

# def includes_word?(word)
#   word_array = word.split('')
#   guesses_array = ["h", "a"]
#   guesses_array.each do |value|
#     if
#   end
# end

def display_guess_word(word, guesses_array)
  # admin_word = "hangman"
  word_display = []
  # guesses_array = ["h", "a"]
  word_array = word.split('') # check that param is safe to use.

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
  puts "Welcome to HANGMAN, mannnnn."
  hangman_guess_word = admin_input
  check_input_type(hangman_guess_word)
  user_guess
end

run_hangman
