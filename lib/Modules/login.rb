module Login
  @@colorizer = Lolize::Colorizer.new
  @@prompt = TTY::Prompt.new

  def load_users
    User.new(name: "Steve", username: "stephenmckeon", password: "love2code",
             market: "Pitman", birthday: "05/26")
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
    @password = @@prompt.mask("Password:".yellow)
    if User.verify_account(@username, @password)
      login_success
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
    login_success_message
    @user = User.find_user_by_username(@username)
    check_birthday
  end

  def login_success_message
    puts
    puts "Login Successful!".blue
    sleep 0.7
    puts
    print "Loading account".blue
    sleep 0.5
    print_three_dots
    puts
  end

  def print_three_dots
    3.times do
      print ".".blue
      sleep 0.7
    end
  end

  def check_birthday
    return unless Time.now.strftime("%m/%d") == @user.birthday

    @@colorizer.write File.open("./lib/Ascii Art/AsciiArtBday").read
  end
end
