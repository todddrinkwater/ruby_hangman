class State
  attr_accessor :letters_remaining, :correct_guesses, :incorrect_guesses, :word_display, :total_lives, :lives_remaining
  def initialize
    @total_lives = 7
    @correct_guesses = []
    @incorrect_guesses = []
    @word_display = []
  end

  def player_progress(admin_input)
    admin_input_arr = admin_input.chars
    @word_display = admin_input_arr.map { |letter|  correct_guesses.include?(letter) ? letter : "_" }
  end

  def lives_remaining
    total_lives - incorrect_guesses.length
  end

  def letters_remaining
    word_display.count("_")
  end
end
