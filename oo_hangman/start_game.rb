require "./hangman.rb"


start = Controller.new(InputOutput.new)
start.new_game
start.input_guess_word
