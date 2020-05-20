class Message

  @@colorizer = Lolize::Colorizer.new
  # @@colorizer.write

  def self.back_or_exit
    puts
    puts "Type 'back' to go back to the listings page or type 'exit' to exit."
    puts
  end

  def self.description
    puts
    puts "Description".underline
    puts
  end

  def self.exit
    puts
    puts "Happy house hunting. Goodbye!"
  end

  def self.invalid_address
    puts
    puts "Invalid input...".red
    puts "Please type the address " + "exactly ".italic + \
         "as seen in the listing"
    puts "or type a valid command. Thank-you!"
    puts
  end

  def self.invalid_input
    puts
    puts "Invalid input... please try again.".red
    puts
  end

  def self.ogin_fail
    puts
    puts "Incorrect username or password, please try again.".red
    puts
    sleep(3)
    login
  end

  def self.login_success
    puts
    puts "Login Successful!".blue
    sleep 1
    puts
    print "Loading account".blue
    sleep 1
    3.times do
      print ".".blue
      sleep 1
    end
  end

  def self.prompt_user
    puts "To see more " + "information ".blue + "on a property, type its " + \
         "address ".yellow + "and press enter."
    puts "To " + "exit".red + ", " + "type " + "'exit'."
    puts
  end

  def self.welcome_message
    puts
    puts
    puts "Hello, user! Welcome to the CLI property search."
    puts "Here are today's multifamily listings in Vineland, NJ:"
    sleep 2
  end
end
