class InputOutput
  attr_reader :welcome_message

  def welcome_message
    puts "WELCOME to HANGMAN, MANNNNNN"
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
end
