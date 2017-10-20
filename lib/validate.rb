class Validate

  def admin_input_length_ok?(admin_input)
    return false unless admin_input
    if admin_input.length < 1 then false
    else
      true
    end
  end

  def input_type_ok?(admin_input)
    regex_comparison = /[\d\s_\W]/
    type_check = admin_input.scan(regex_comparison)

    type_check.length < 1 ? true : false
  end

  def player_input_length_ok?(user_input)
    user_input.length == 1
  end

end
