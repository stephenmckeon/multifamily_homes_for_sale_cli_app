# This class is responsible for communication with the user
# This is where I will use 'puts'
# This will never use nokogiri
# This will invoke Scraper

class Cli
  # --IDEAS--
  ## have a profile setup with password that knows your default seach area
  ## have guest profile with no password that makes you select an area to search

  def call
    Scraper.new.scrape_listings
    welcome_message
    start
  end

  def welcome_message
    puts "Hello, user! Welcome to the CLI property search."
    puts "Here are today's properties in Vineland, NJ:"
  end

  def start
    display_properties
    prompt_user
    input
    until user_input_exit?
      invalid_address?
      display_details
      start if user_input_back?
    end
    exit
  end

  def display_properties
    puts
    Property.all.each do |home|
      puts home.address
      puts "➼ #{home.price}"
      puts "➼ #{home.beds}"
      puts "➼ #{home.baths}"
      puts "➼ #{home.sqft}"
      puts
    end
  end

  def prompt_user
    puts "To see more information on a property, type its address and press enter."
    puts "To exit, type 'exit'."
    puts
  end

  def input
    @user_input = gets.strip
  end

  def display_details
    puts
    Scraper.scrape_property_details(@user_input)
    puts
    puts "Type 'back' to go back to the listings page or type 'exit' to exit."
    puts
    input
  end

  def invalid_input
    puts "Invalid input... please try again."
    puts
  end

  def invalid_address?
    if Scraper.find_property(@user_input).nil?
      puts
      puts "Invalid input..."
      puts "Please type the address EXACTLY as seen in the listing"
      puts "or type a valid command. Thank-you!"
      puts
      input
    end
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
