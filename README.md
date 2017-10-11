# ruby_hangman
Hangman built in Ruby


- Write a hangman game (try writing some components test-first with RSpec)
- Apply OO principles from POODR etc.
- Group code reviews

- As a hangman player, I would like to be able to start a new game of hangman
- As a hangman player, I would like to see some indication of how many letters there are in the word that I am supposed to guess
- As a hangman player, I want to submit one letter guesses and be told whether my guess is either in the word, not in the word, or already guessed
- As a hangman player, I want the game to handle bad input (like numbers, symbols, and letters I've previously guessed) gracefully and with an appropriate error message so that I am not punished unduly for mistakes
- As a hangman player, I want to see the letters I've guessed correctly revealed on the hidden word that I am trying to guess so that I can guess the word more readily
- As a hangman player, I want to see the letters I've guessed incorrectly so that I don't guess the same wrong letter again
- As a hangman player, I would like to see how many lives are remaining
- As a hangman player, I must have 1 life deducted every time I make an incorrect guess of a letter that I have not already guessed
- As a hangman player, I want the game to end when I have run out of lives
- As a hangman player, I want the game to end when I have guessed the full word

Game Flow
1. Start game X
2. Admin input for word to guess X
3. Type checking X

4. Display word length with letters replaced with _ 's X
5. User inputs single letter X
6. User type checking X
7. Check if letter is in word X
7a. Decrease words remaining count by number of letter matches X
7b. Call display word function X
8. Check count
a. If guessesRemaining > 0 and lettersRemaining > 1 run game guess process again
b. If guessesRemaining < 0 display "GAME OVER."
b. Display "You win!" if letters remaining < 1

OO Game Flow
1. Start game X
2. Admin input for word to guess X
3. Admin Type checking X

4. Display word length with letters replaced with _ 's x
5. User inputs single letter
6. User type checking
7. Check if letter is in word
7a. Decrease words remaining count by number of letter matches
7b. Call display word function
8. Check count
a. If guessesRemaining > 0 and lettersRemaining > 1 run game guess process again
b. If guessesRemaining < 0 display "GAME OVER."
b. Display "You win!" if letters remaining < 1

Tests...
