require_relative "./game_two.rb"

game = GameTwo.new(lives_remaining: 7, guess_word: "dog")
game.start_game
game.play_turn