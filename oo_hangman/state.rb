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
