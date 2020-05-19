# This class is responsible for communication with the user
# This is where I will use 'puts'
# This will never use nokogiri
# This will invoke Scraper

class Cli
  # --IDEAS--
  # find_or_update_by
  ## have a profile setup with password that knows your default seach area
  ## have guest profile with no password that makes you select an area to search

  def call
    Scraper.new.scrape_listings
    welcome_message
    start
  end

  def welcome_message
    puts "Hello, user! Welcome to the CLI property search."
    puts "Here are today's multifamily listings in Vineland, NJ:"
  end

  def start(to_exit = true)
    display_properties
    prompt_user
    continue
    exit if to_exit
  end

  def display_properties
    puts
    Property.all.each do |home|
      puts "‣ " + home.address.bold.underline
      puts "  ➼ #{home.price}".green
      puts "  ➼ #{home.beds}"
      puts "  ➼ #{home.baths}"
      puts "  ➼ #{home.sqft}"
      puts
      sleep 0.5
    end
  end

  def prompt_user
    puts "To see more information on a property, type its address and press enter."
    puts "To exit, type 'exit'."
    puts
  end

  def continue
    input
    unless user_input_exit?

      return if invalid_address?

      display_details
    end
    start(false) if user_input_back?
  end

  def input
    @user_input = gets.strip
  end

  def invalid_address?
    return unless Scraper.find_property(@user_input).nil?

    puts
    puts "Invalid input...".red
    puts "Please type the address " + "exactly ".italic + \
    "as seen in the listing"
    puts "or type a valid command. Thank-you!"
    puts
    continue
    true
  end

  def display_details
    puts
    Scraper.scrape_property_details(@user_input)
    puts
    puts "Type 'back' to go back to the listings page or type 'exit' to exit."
    puts
    input
    until valid_input?("exit", "back")
      invalid_input
      input
    end
  end

  def valid_input?(*input)
    input.any? { |word| word == @user_input }
  end

  def invalid_input
    puts
    puts "Invalid input... please try again.".red
    puts
  end

  def user_input_exit?
    @user_input.casecmp("exit").zero?
  end

  def user_input_back?
    @user_input.casecmp("back").zero?
  end

  def exit
    puts
    puts "Happy house hunting. Goodbye!"
  end
end
