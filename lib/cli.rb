require_relative "./Modules/display.rb"
require_relative "./Modules/input.rb"
require_relative "./Modules/login.rb"
require_relative "./Modules/message.rb"

# --IDEAS--
# build README
# class << Self
# reader/writer

class Cli
  include Display
  include Input
  include Login
  include Message

  def call
    load_users
    login
    @@count = 1
    welcome_message
    start
  end

  def start
    City.find_or_create_cities
    select_market
    select_property
  end

  def select_market
    default_city?
    display_market
    user_city_message
    select_market_input
  end

  def select_property
    city = City.find_city(@market_input)
    loading_city_message(city)
    Property.find_or_scrape_properties(@market_input)
    if listings_in_city?(city) == false
      no_listings_message(city)
      start
    else
      display_property_and_details(city)
    end
  end

  def display_property_and_details(city)
    display_properties(city)
    user_address_message
    select_property_input
    show_details
  end

  def show_details
    Property.find_or_create_details(@property_input)
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

  def details_display(address)
    property = Property.find_property(address)
    display_description_and_details(property)
  end

  def price_insights(address)
    see_price_insights_message(@user_input)
    input
    until_valid_input("yes", "no")
    return if @user_input == "no"

    price_insights_display(address)
  end

  def price_insights_display(address)
    property = Property.find_property(address)
    display_price_insights_info(property)
  end

  def invalid_city?
    return unless City.find_city(@market_input).nil?

    invalid_selection_message
    select_market_input
    true
  end

  def invalid_address?
    return unless Property.find_property(@property_input).nil?

    invalid_selection_message
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

  def listings_in_city?(city)
    !city.properties.empty?
  end
end
