class InputOutput
  attr_reader :welcome_message

  def welcome_message
    puts "WELCOME to HANGMAN, MANNNNNN"
  end

  def admin_input
    puts "Please enter your choosen word:"
    @input = gets.chomp
  end

  def admin_input_message
    puts "Please enter your guess word:"
  end
end
