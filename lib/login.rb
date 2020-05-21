module Login
  @@colorizer = Lolize::Colorizer.new

  def load_users
    User.new(name: "Steve", username: "stephenmckeon", password: "love2code",
             market: "Mantua Township", birthday: "05/21/2020")
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
      check_birthday
    else
      login_fail
    end
  end

  def guest_mode
    @user = User.new(name: "guest", username: "", password: "", market: "",
                     birthday: "")
  end

  def login_fail
    puts
    puts "Incorrect username or password, please try again.".red
    puts
    sleep(2)
    login
  end

  def login_message
    puts
    puts "Welcome to the CLI property search!".blue
    puts "To continue, type 'login' to login or ".blue + \
         "type 'guest' to continue as guest user.".blue
    puts
  end

  def login_success
    puts
    puts "Login Successful!".blue
    sleep 0.7
    puts
    print "Loading account".blue
    sleep 0.5
    3.times do
      print ".".blue
      sleep 0.7
    end
    puts
  end

  def check_birthday
    return unless Time.now.strftime("%m/%d/%Y") == @user.birthday

    @@colorizer.write File.open("./lib/Ascii Art/AsciiArtBday").read
  end
end
