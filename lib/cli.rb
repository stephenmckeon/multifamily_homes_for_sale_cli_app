# This class is responsible for communication with the user
# This is where I will use 'puts'
# This will never use nokogiri
# This will invoke Scraper
require_relative "./message"
require_relative "./input"
require_relative "./login"

class Cli
  # --IDEAS--
  # Dont' Scrape until after login success, then scrape. Remove sleep after Hello, guest! and scrape then
  # select a market to search after welcome message
  ## have a profile setup with password that knows your default seach area
  ## have guest profile with no password that makes you select an area to search

  include Message
  include Input
  include Login

  def call
    @scraper = Scraper.new
    @scraper.scrape_cities
    load_users
    login
    welcome_message
    start
  end



  def select_market
    display_market
    prompt_user_city
    input
  end

  def guest_mode
    @user = User.new(name: "guest", username: "", password: "", market: "")
  end

  def start(to_exit = true)
    until @user_input == "exit"
      select_market
      select_property
      display_details
    end
    exit if to_exit
  end

  def select_property
    @scraper.scrape_listings(@user_input)
    display_properties
    prompt_user_address
    input
  end

  # def continue
  #   input
  #   unless user_input_exit?
  #     return if invalid_city?

  #     @scraper.scrape_listings(@user_input)
  #     display_properties
  #     prompt_user_address
  #   end
  #   start(false) if user_input_back?
  # end

  def invalid_city?
    return unless Scraper.find_city(@user_input).nil?

    invalid_selection
    continue
    true
  end

  def invalid_address?
    return unless Scraper.find_property(@user_input).nil?

    invalid_selection
    continue
    true
  end

  def display_details
    find_or_create_details(@user_input)
    details_display(@user_input)
    price_insights(@user_input)
    back_or_exit
    input
    until_valid_input("exit", "back")
  end

  def find_or_create_details(address)
    property = Scraper.find_property(address)
    return unless property.description.nil?

    Scraper.scrape_home_facts(@user_input)
    Scraper.scrape_price_insights(@user_input)
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
