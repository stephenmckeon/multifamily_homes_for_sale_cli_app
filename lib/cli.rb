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

  def start
    display_properties
    prompt_user
    display_details
  end

  def welcome_message
    puts "Hello, user! Welcome to the CLI property search."
    puts "Here are today's properties in Vineland, NJ:"
    puts
  end

  def display_properties
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
    puts
    @user_input = gets.strip
  end

  def display_details
    puts
    Scraper.scrape_property_details(@user_input)
    puts
    puts "To go back to the listings, type 'back' or tpye 'exit' to exit."
    puts
    @user_input = gets.strip
    if @user_input == "back"
      start
    elsif @user_input == "exit"
      return
    end
  end
end
