#big bag of state
class State
  attr_reader :lives_remaining
  attr_accessor :letters_remaining, :correct_guesses_arr, :incorrect_guesses_arr
  def initialize
    @lives_remaining = 7
    @letters_remaining = 7 #change to length of hangman word later on.
    @correct_guesses_arr = []
    @incorrect_guesses_arr = []
  end

  # def has_the_player_won_yet?
  #   false if something
  # end

end

class ProcessGameState

  # def display_guess_word_progess(hangman_word)
  #   word_display = []
  #   word_array = hangman_word.chars
  #
  #   hangman_word_length = hangman_word.length
  #   hangman_word_length.times { word_display.push("_") }
  #
  #   word_display = word_array.map { |letter| $guesses_array.include?(letter) ? letter : "_"}
  #
  #   $letters_remaining = word_display.count("_")
  #   print "GUESS WORD: #{word_display.join(" ")}\n"
  # end

  def validate_admin_input(admin_input)
    regex_comparison = /[\d\s_\W]+/
    type_check = admin_input.scan(regex_comparison)
    if type_check.length < 1
      admin_input.downcase!
    else
      print "Please enter only letter characters (incl. no spaces)"
    end
  end

end

# controller is purely an orchestrator
class Controller
  def initialize(output, input)
    @output = output
    @input = input
    @state = State.new
    @process_game_state = ProcessGameState.new
  end

  def new_game
    @output.welcome_message
  end

  def input_guess_word
    @admin_input = @input.admin_input
    @process_game_state.validate_admin_input(@admin_input)

  end

  # def display_game_status
  #   puts "{Lives: #{@state.lives_remaining}}"
  #   @state.letters_remaining = @admin_input.length
  #   puts @state.letters_remaining
  # end


end

# Everything from here down is screen is business

class Input
  def admin_input
    puts "Please enter your choosen word:"
    @input = gets.chomp
  end
end

class Output
  attr_reader :welcome_message
  def welcome_message
    puts "WELCOME to HANGMAN, MANNNNNN"
  end

  def admin_input_message
    puts "Please enter your guess word:"
  end
end
