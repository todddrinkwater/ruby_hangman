class InputOutput
  attr_reader :welcome_message
  def initialize
    super
  end

  def welcome_message
    puts "WELCOME to HANGMAN, MANNNNNN \n - - - - - - - - - - - - -"
  end

  def admin_input_message
    puts "Please enter your choosen word:"
  end

  def admin_input
    gets.chomp
  end

  def admin_input_message
    puts "Please enter your guess word:"
  end

  def user_input
    puts "Please guess a letter:"
    gets.chomp
  end

  def display_lives_remaining(lives_remaining)
    puts "--> 😩 Lives remaining: #{lives_remaining}"
  end

end
