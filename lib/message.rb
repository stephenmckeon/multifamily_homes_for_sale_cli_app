module Message
  @@colorizer = Lolize::Colorizer.new
  # @@colorizer.write

  def back_exit_or_open_message
    puts
    puts "Type 'open' to " + "open ".white.bold + "this listing in browser, " + \
         "type 'back' to go " + "back ".cyan + \
         "to the listings page, or type 'exit' to " + "exit".red + "."
    puts
  end

  def display_description_and_details(property)
    puts File.open(property.ascii_art).read
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

  def display_properties(city)
    listings_in_city?(city)
    puts
    city.properties.each do |home|
      puts "‣ " + home.address.underline.yellow
      puts "  ➼ #{home.price}".green
      puts "  ➼ #{home.beds}"
      puts "  ➼ #{home.baths}"
      puts "  ➼ #{home.sqft}"
      puts
      sleep 0.2
    end
  end

  def listings_in_city?(city)
    return unless city.properties.empty?

    puts
    puts "Sorry, there are currently no listings in ".red \
          + city.name.yellow + "!"
    puts
    sleep 1
    puts "Returning to city selection...."
    sleep 2
    select_market
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
    puts "List Price:        ".light_black.bold + property.price + \
         "     Est. Mo. Payments:  ".bold.light_black + property.est_mo_payment
    puts "Redfin Est Price:  ".bold.light_black + property.est_price + \
         "     Price/Sqft:         ".bold.light_black + property.price_sqft
  end

  def prompt_user_city
    puts "Please select a city to search by typing it's name."
    puts "You can also type 'sign out' to sign out, or type 'exit' to exit."
    puts
  end

  def prompt_user_address
    puts "To see more " + "information ".blue + "on a property, type its " + \
         "address ".yellow + "and press enter."
    puts "To go " + "back ".cyan + "to city selection, type 'back'. To " + \
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
    puts "Loading cities in and around Gloucester County..."
  end
end
