require_relative "./message"
require_relative "./input"
require_relative "./login"

class Cli
  # --IDEAS-=
  # build README
  # class << Self
  # refactor self.scrape_home_facts(address)
  # puts can be replaced by \n \ ... ask andrew or pat
  # Where should each method really be? find_city in Scraper??? NOOOO!!!

  include Message
  include Input
  include Login

  def call
    @scraper = Scraper.new
    load_users
    login
    @@count = 1
    welcome_message
    start
  end

  def start
    find_or_create_cities
    select_market
    select_property
  end

  def select_market
    default_city?
    display_market
    prompt_user_city
    select_market_input
  end

  def select_property
    city = City.find_city(@market_input)
    loading_city_message(city)
    find_or_scrape_properties(@market_input)
    display_properties(city)
    prompt_user_address
    select_property_input
    display_details
  end

  def display_details
    find_or_create_details(@property_input)
    details_display(@property_input)
    price_insights(@property_input)
    back_exit_or_open_message
    back_open_exit_prompt
  end

  def back_open_exit_prompt
    input
    until_valid_input("exit", "back", "open")
    open_property if @user_input == "open"
    select_property if @user_input == "back"
  end

  def find_or_create_cities
    @scraper.scrape_cities if City.all.empty?
  end

  def find_or_scrape_properties(city_name)
    city = City.find_city(city_name)
    @scraper.scrape_listings(city) if city.properties.empty?
  end

  def find_or_create_details(address)
    property = Property.find_property(address)
    return unless property.description.nil?

    Scraper.scrape_home_details(@property_input)
  end

  def details_display(address)
    property = Property.find_property(address)
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
    property = Property.find_property(address)
    price_insights_info(property)
  end

  def invalid_city?
    return unless City.find_city(@market_input).nil?

    invalid_selection
    select_market_input
    true
  end

  def invalid_address?
    return unless Property.find_property(@property_input).nil?

    invalid_selection
    select_property_input
    true
  end

  def open_property
    property = Property.find_property(@property_input)
    Launchy.open(property.link)
    back_open_exit_prompt
  end

  def default_city?
    return if @user.market == "" || @@count > 1

    @@count += 1
    @market_input = @user.market
    select_property
  end
end
