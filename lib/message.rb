module Message
  @@colorizer = Lolize::Colorizer.new
  # @@colorizer.write

  def back_or_exit
    puts
    puts "Type 'back' to go " + "back ".white.bold + \
         "to the listings page or type 'exit' to " + "exit".red + "."
    puts
  end

  def display_description_and_details(property)
    puts
    puts "Description".underline
    puts
    puts property.description.blue
    puts
    puts "Year Built: ".light_black.bold + property.year_built + \
         "     Lot Size: ".light_black.bold + property.lot_size + \
         "     Time on Market: ".light_black.bold + property.time_on_market
    puts
  end

  def display_market
    puts
    puts
    City.all.each do |city|
      puts "‣ " + city.name.light_yellow
      sleep 0.2
    end
    puts
  end

  def display_properties
    Property.all.each do |home|
      puts "‣ " + home.address.underline.yellow
      puts "  ➼ #{home.price}".green
      puts "  ➼ #{home.beds}"
      puts "  ➼ #{home.baths}"
      puts "  ➼ #{home.sqft}"
      puts
      sleep 0.2
    end
  end

  def goodbye
    puts
    @@colorizer.write "Happy house hunting. Goodbye!"
    puts
    exit
  end

  def invalid_selection
    puts
    puts "Invalid input...".red
    puts "Please type your selection " + "exactly ".italic + \
         "as seen in the list"
    puts "or type a valid command. Thank-you!"
    puts
  end

  def invalid_input
    puts
    puts "Invalid input... please try again.".red
    puts
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

  def price_insights_info(property)
    puts
    puts "List Price:        ".bold + property.price + \
         "     Est. Mo. Payments:  ".bold + property.est_mo_payment
    puts "Redfin Est Price:  ".bold + property.est_price + \
         "     Price/Sqft:         ".bold + property.price_sqft
  end

  def prompt_user_city
    puts "Please select a city to search by typing it's name."
    puts "You can also type 'sign out' to sign out, or type 'exit' to exit."
  end

  def prompt_user_address
    puts "To see more " + "information ".blue + "on a property, type its " + \
         "address ".yellow + "and press enter."
    puts "To go back to city selection, type 'back'. To " + \
         "exit".red + ", " + "type " + "'exit'."
    puts
  end

  def see_price_insights?(user_input)
    puts "Would you like to see " + "price insights ".green + \
         "for " + user_input.yellow + "?"
    puts "(type " + "'yes'".light_black.on_green + \
         " or " + "'no'".white.on_red + ")"
    puts
  end

  def welcome_message
    sleep 1
    puts
    print "Hello, "
    @@colorizer.write @user.name
    print "! Welcome to the CLI property search. "
    puts
    puts "Loading cities in Gloucester County..."
  end
end
