module Login
  def load_users
    User.new(name: "Steve", username: "stephenmckeon", password: "love2code", \
             market: "Mantua Township")
  end

  def login
    login_message
    input
    puts
    until_valid_input("login", "guest")
    @user_input == "login" ? verify_login : guest_mode
  end

  def verify_login
    print "Username: ".yellow
    @username = gets.chomp
    print "Password: ".yellow
    @password = gets.chomp
    if User.verify_account(@username, @password)
      login_success
      @user = User.find_user_by_username(@username)
    else
      login_fail
    end
  end

  def guest_mode
    @user = User.new(name: "guest", username: "", password: "", market: "")
  end
end