class Validate # Don't break up into other classes until you see a need / clear theme.

  def validate_admin_input(admin_input)
    return false unless admin_input
    regex_comparison = /[\d\s_\W]+/
    type_check = admin_input.scan(regex_comparison)
    if admin_input.length < 1
      puts "Please enter at least one letter."
      false
    elsif type_check.length < 1
      admin_input.downcase!
      true
    else
      puts "Please enter only letter characters (incl. no spaces)\n"
      false
    end
  end


# --------------------

  def validate_input_length(admin_input)
    puts "input --> #{admin_input}"
    return false unless admin_input
    if admin_input.length < 1
      false
    else
      return true
    end
  end

  def validate_admin_input(admin_input)
    regex_comparison = /[\d\s_\W]+/
    type_check = admin_input.scan(regex_comparison)
    if admin_input.length < 1
      more_letters
      false
    elsif type_check.length < 1
      admin_input.downcase!
      true
    else
      puts "Please enter only letter characters (incl. no spaces)\n"
      false
    end
  end
# --------------------
  def validate_player_input(user_input)
    regex_comparison = /[\d\s_\W]/
    type_check = user_input.scan(regex_comparison)
    puts type_check
    if (user_input.length > 1) || (user_input.length <= 0)
      puts "Please enter ONLY a single letter."
      false
    elsif type_check.length > 0
      puts "Please use only letters."
      false
    else
      true
    end
  end

end
