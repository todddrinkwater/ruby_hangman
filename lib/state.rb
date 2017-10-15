class State
  attr_accessor :letters_remaining, :correct_guesses, :incorrect_guesses, :word_display, :total_lives
  def initialize
    @total_lives = 7
    @letters_remaining = 7 #change to length of hangman word later on.
    @correct_guesses = []
    @incorrect_guesses = []
    @word_display = []
  end

  # def has_the_player_won_yet?
  #   false if something
  # end
end
