# This class is responsible for communication with the user
# This is where I will use 'puts'
# This will never use nokogiri
# This will invoke Scraper

class Cli
  # have a profile setup with password that knows your default seach area
  # have guest profile with no password that makes you select an area to search

  def call
    Scraper.new.scrape_listings
    welcome_message
    display_properties
  end

  def start
    # call this method @ line 13
  end

  def welcome_message
    puts "Hello, user! Welcome to the CLI property search."
    puts "Here are today's properties in Vineland:"
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
end
