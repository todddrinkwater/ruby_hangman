require "./hangman.rb"


start = Controller.new(Output.new, Input.new)
start.new_game
start.input_guess_word
