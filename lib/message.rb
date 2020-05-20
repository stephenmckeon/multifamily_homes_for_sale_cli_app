class Message

  @@colorizer = Lolize::Colorizer.new
  # @@colorizer.write

  def self.back_or_exit
    puts
    puts "Type 'back' to go " + "back ".white + "to the listings page or type 'exit' to " + "exit".red + "."
    puts
  end

  def self.description_and_details(property)
    puts
    puts "Description".underline
    puts
    puts property.description.blue
    puts
    puts "Year Built: ".bold + property.year_built + \
         "     Lot Size: ".bold + property.lot_size + \
         "     Time on Market: ".bold + property.time_on_market
    puts
  end

  def self.display_properties
    puts
    Property.all.each do |home|
      puts "‣ " + home.address.underline
      puts "  ➼ #{home.price}".green
      puts "  ➼ #{home.beds}"
      puts "  ➼ #{home.baths}"
      puts "  ➼ #{home.sqft}"
      puts
      sleep 0.3
    end
  end

  def self.exit
    puts
    @@colorizer.write "Happy house hunting. Goodbye!"
    puts
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

  def self.login_fail
    puts
    puts "Incorrect username or password, please try again.".red
    puts
    sleep(3)
    login
  end

  def self.login_message
    print "Welcome to the CLI property search. Please login to continue:".blue
    puts
    print "Username: ".yellow
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

  def self.see_price_insights?(user_input)
    puts "Would you like to see " + "price insights ".green + \
         "for " + user_input.yellow + "?"
    puts "(type " + "'yes'".black.on_green + " or " + "'no'".white.on_red + ")"
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
