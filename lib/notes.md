How do I go about passing in a guess word to GameTwo and keep it private?
Will initializing it and then calling it only from a private method work?

Process?
Start creating separate specs for State and Console_UI, then build?

Plan:
1. Create tests to check if:
  a. Game takes a word and initializes it
  b. Word is held within method that is private.
  
2. Create state2_spec
  a. Write tests for state to check it initializes lives_remaining and guesses.

3. Create state2 and initialize variable.

4. 


# Until lives remaining is 0 or all letters guessed
  # Display current state of the game X
  # Get a guess from player
  # If guess has already been made, tell the player X
  # Elsif guess is in word, then show letter in word X
  # Elsif guess is not in word, take a life X
# Tell player if they've won or lost

# Can only create a method if required by public interface or it is repeated for the third time.

#Checking the status of the game
# Check if game is over? X
  # Game over - Happens if someone has guessed all letters or runs out of lives. X
    # Game won if user has guessed all letters, lives greater than 0 X
    # Game lost if user has not guessed all letters and lives less than 1 X
  # Game continues when... User still has lives and letters have not all been guessed.
  
# Can a player still make a guess if lost?
# Has a player won if they have guessed the word but their lives are at zero.