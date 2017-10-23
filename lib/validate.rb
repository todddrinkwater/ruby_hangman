class Validate
  def guess_word_accepted?(guess_word)
    guess_word_length_ok?(guess_word) && input_type_ok?(guess_word)
  end
  
  def player_guess_accepted?(player_guess)
    player_guess_length_ok?(player_guess) && input_type_ok?(player_guess)
  end
  
  private
  
  def guess_word_length_ok?(guess_word)
    return false unless guess_word
    if guess_word.length < 1 then false
    else
      true
    end
  end
  
  def player_guess_length_ok?(player_guess)
    player_guess.length == 1
  end

  def input_type_ok?(input)
    regex_comparison = /[\d\s_\W]/
    type_check = input.scan(regex_comparison)

    type_check.length < 1 ? true : false
  end
end
