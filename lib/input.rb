module Input
  def input
    @user_input = gets.strip
    goodbye_message if @user_input == "exit"
  end

  def market_input
    @market_input = gets.strip
    goodbye_message if @market_input == "exit"
  end

  def property_input
    @property_input = gets.strip
    goodbye_message if @property_input == "exit"
    start if @property_input == "back"
  end

  def select_market_input
    market_input
    call if @market_input == "sign out"
    invalid_city?
  end

  def select_property_input
    property_input
    invalid_address?
  end

  def until_valid_input(*spec_input)
    until valid_input?(*spec_input)
      invalid_input_message
      input
    end
  end

  def user_input_exit?
    @user_input.casecmp("exit").zero?
  end

  def user_input_back?
    @user_input.casecmp("back").zero?
  end

  def valid_input?(*spec_input)
    spec_input.any? { |word| word == @user_input }
  end
end
