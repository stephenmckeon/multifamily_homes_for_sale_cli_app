# This class is responsible for communication with the user
# This is where I will use 'puts'
# This will never use nokogiri
# This will invoke Scraper

class Cli
  # have a profile setup with password that knows your default seach area
  # have guest profile with no password that makes you select an area to search



  def call
    run_scraper
    welcome_message
  end

  def run_scraper
    Scraper.new
  end

  def welcome_message

  end
end