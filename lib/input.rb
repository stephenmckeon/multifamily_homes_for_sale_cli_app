module Input
  def valid_input?(*spec_input)
    spec_input.any? { |word| word == @user_input }
  end

  def until_valid_input(*spec_input)
    until valid_input?(*spec_input)
      invalid_input
      input
    end
  end

  def input
    @user_input = gets.strip
  end

  def user_input_exit?
    @user_input.casecmp("exit").zero?
  end

  def user_input_back?
    @user_input.casecmp("back").zero?
  end
end