# This class is responsible for communication with the user
# This is where I will use 'puts'
# This will never use nokogiri
# This will invoke Scraper
require_relative "./message"
require_relative "./input"
require_relative "./login"

class Cli
  # --IDEAS--
  # be more specific on scraping for details
  # add open link feature
  # profile knows birthday
  # puts can be replaced by \n \ ... ask andrew or pat
  ## fix welcome to welcome to Glouster County Cli Prop search
  ## display random ascii art when looking at home details
  ## profile knows your default seach area
  ## guest profile makes you select an area to search
  ## choose multifam or single fam ?

  # Where should each method really be? find_city in Scraper??? NOOOO!!!

  # when a city is seclected the properties that are created belong to a city
  # When a city is called, Cli checks to see if that city already has properties, if it does, then do not create more props
  # if not, make props that belong to city (step1)

  include Message
  include Input
  include Login

  def call
    @scraper = Scraper.new
    load_users
    login
    welcome_message
    start
  end

  def start
    find_or_create_cities
    select_market
    select_property
  end

  def select_market
    display_market
    prompt_user_city
    select_market_input
  end

  def select_market_input
    market_input
    call if @market_input == "sign out"
    invalid_city?
  end

  def select_property
    find_or_scrape_properties(@market_input)
    # @scraper.scrape_listings(@market_input) # here is where Prop are made; turn this into find or create props
    city = Scraper.find_city(@market_input)
    display_properties(city)
    prompt_user_address
    select_property_input
    display_details
  end

  def select_property_input
    input
    start if @user_input == "back"
    invalid_address?
  end

  def display_details
    find_or_create_details(@user_input)
    details_display(@user_input)
    price_insights(@user_input)
    back_or_exit
    input
    until_valid_input("exit", "back")
    select_property if @user_input == "back"
  end

  def find_or_create_cities
    @scraper.scrape_cities if City.all.empty?
  end

  def find_or_scrape_properties(city_name)
    city = Scraper.find_city(city_name)
    @scraper.scrape_listings(city) if city.properties.empty?
  end

  def find_or_create_details(address)
    property = Scraper.find_property(address)
    return unless property.description.nil?

    Scraper.scrape_home_facts(@user_input)
    Scraper.scrape_price_insights
  end

  def details_display(address)
    property = Scraper.find_property(address)
    display_description_and_details(property)
  end

  def price_insights(address)
    see_price_insights?(@user_input)
    input
    until_valid_input("yes", "no")
    return if @user_input == "no"

    price_insights_display(address)
  end

  def price_insights_display(address)
    property = Scraper.find_property(address)
    price_insights_info(property)
  end
end

def invalid_city?
  return unless Scraper.find_city(@market_input).nil?

  invalid_selection
  select_market_input
  true
end

def invalid_address?
  return unless Scraper.find_property(@user_input).nil?

  invalid_selection
  select_property_input
  true
end
