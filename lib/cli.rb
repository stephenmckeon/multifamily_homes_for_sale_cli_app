# This class is responsible for communication with the user
# This is where I will use 'puts'
# This will never use nokogiri
# This will invoke Scraper

class Cli
  # --IDEAS--
  ## have a profile setup with password that knows your default seach area
  ## have guest profile with no password that makes you select an area to search
  # use user input (address) to display more info  about the home

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
    until user_input_exit?
      display_details
    end
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
    puts "To exit"
    puts
    input
  end

  def input
    @user_input = gets.strip
    puts
    exit if user_input_exit?

    invalid_address if Scraper.find_property(@user_input).nil?
  end

  def display_details
    puts
    Scraper.scrape_property_details(@user_input)
    puts
    puts "Typ 'back' to go back to the listings page. Tpye 'exit' to exit."
    puts
    @user_input = gets.strip

    start if @user_input == "back"
  end

  def invalid_address
    puts "Invalid address..."
    puts "Please type the address EXACTLY as seen in the listing."
    puts
    input
  end

  def invalid_input
    puts "Invalid input... please try again."
    puts
  end

  def user_input_exit?
    @user_input.casecmp("exit").zero?
  end

  def exit
    puts
    puts "Happy house hunting. Goodbye!"
  end
end
