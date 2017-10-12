class Validate # Don't break up into other classes until you see a need / clear theme.

  def validate_admin_input(admin_input)
    regex_comparison = /[\d\s_\W]+/
    type_check = admin_input.scan(regex_comparison)
    if type_check.length < 1
      admin_input.downcase!
      return true
    else
      print "Please enter only letter characters (incl. no spaces)\n"
      return false
    end
  end

  def validate_player_input(user_input)
    regex_comparison = /[\d\s_\W]/
    type_check = user_input.scan(regex_comparison)
    puts type_check
    if (user_input.length > 1) || (user_input.length <= 0)
      puts "Please enter ONLY a single letter."
      return false
    elsif type_check.length > 0
      puts "Please use only letters."
      return false
    else
      return true
    end
  end

end
