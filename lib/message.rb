require_relative "./format.rb"

module Message
  @@colorizer = Lolize::Colorizer.new

  include Format

  def back_exit_or_open_message
    puts "\nType 'open' to " + "open ".white.bold + \
         "this listing in browser, type 'back' to go " + "back ".cyan + \
         "to the listings page, or type 'exit' to " + "exit".red + ".\n\n"
  end

  def goodbye_message
    puts
    @@colorizer.write "Happy house hunting. Goodbye!\n\n"
    exit
  end

  def no_listings_message(city)
    puts "\nSorry, there are currently no listings in ".red \
          + city.name.yellow + "!\n\n"
    sleep 1
    puts "Returning to city selection...."
    sleep 2
  end

  def loading_city_message(city)
    puts "\nLoading properties in " + city.name.yellow + "..."
    sleep 2
  end

  def invalid_selection_message
    puts "\nInvalid input...".red
    puts "Please type your selection " + "exactly ".italic + \
         "as seen in the list"
    puts "or type a valid command. Thank-you!\n\n"
  end

  def invalid_input_message
    puts "\nInvalid input... please try again.\n\n".red
  end

  def display_price_insights_info(property)
    puts light_black_bold("\nList Price:        ") + property.price + \
         light_black_bold("     Est. Mo. Payments:  ") + property.est_mo_payment
    puts light_black_bold("Redfin Est Price:  ") + property.est_price + \
         light_black_bold("     Price/Sqft:         ") + property.price_sqft
  end

  def user_city_message
    puts "Please select a " + "city ".yellow + "to search by typing it's name."
    puts "You can also " + "sign out ".cyan + "by typing 'sign out'" \
         ", or " + "exit ".red + "by typing 'exit'.\n\n"
  end

  def user_address_message
    puts "To see more " + "information ".blue + "on a property, type its " + \
         "address ".yellow + "and press enter."
    puts "To go " + "back ".cyan + "to city selection, type 'back'. To " + \
         "exit".red + ", " + "type 'exit'.\n\n"
  end

  def see_price_insights_message(user_input)
    puts "Would you like to see " + "price insights ".green + \
         "for " + user_input.yellow + "?"
    puts "(type " + light_black_on_green("'yes'") + \
         " or " + white_on_red("'no'") + ")\n\n"
  end

  def welcome_message
    sleep 1
    print "\nHello, "
    @@colorizer.write @user.name
    print "! "
    @@colorizer.write "Welcome to the CLI multi-family property search"
    print "!"
    puts "\nLoading cities in and around " + "Gloucester County".yellow + "..."
  end
end
