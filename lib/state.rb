class State
  attr_accessor :letters_remaining, :correct_guesses, :incorrect_guesses, :word_display, :total_lives, :lives_remaining
  def initialize
    @total_lives = 7
    @correct_guesses = []
    @incorrect_guesses = []
    @word_display = []
  end

  def player_progress(guess_word)
    guess_word_arr = guess_word.chars
    @word_display = guess_word_arr.map { |letter|  correct_guesses.include?(letter) ? letter : "_" }
  end

  def lives_remaining
    total_lives - incorrect_guesses.length
  end

  def letters_remaining
    word_display.count("_")
  end

  def update_guesses_made(correct, user_guess)
    if correct
      correct_guesses.push(user_guess)
    else
      incorrect_guesses.push(user_guess)
    end
  end

end
