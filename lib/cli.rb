# This class is responsible for communication with the user
# This is where I will use 'puts'
# This will never use nokogiri
# This will invoke Scraper
require_relative "./message"

class Cli
  # --IDEAS--
  # select a market to search after welcome message
  ## have a profile setup with password that knows your default seach area
  ## have guest profile with no password that makes you select an area to search

  # welcome, to login type login. to continue as guest, type guest. to exit, type exit.

  include Message

  def call
    Scraper.new.scrape_listings
    load_users
    login
    welcome_message
    start
  end

  def load_users
    User.new(name: "Steve", username: "stephenmckeon", password: "love2code")
  end

  def login
    login_message
    input
    puts
    until valid_input?("login", "guest")
      invalid_input
      input
    end
    @user_input == "login" ? verify_login : guest_mode
  end

  def verify_login
    print "Username: ".yellow
    @username = gets.chomp
    print "Password: ".yellow
    @password = gets.chomp
    if User.verify_account(@username, @password)
      login_success
      @user = User.find_user_by_username(@username)
    else
      login_fail
    end
  end

  def guest_mode
    @user = User.new(name: "guest", username: "", password: "" )
  end

  def start(to_exit = true)
    display_properties
    prompt_user
    continue
    exit if to_exit
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

    invalid_address
    continue
    true
  end

  def display_details
    find_or_create_details(@user_input)
    details_display(@user_input)
    price_insights(@user_input)
    back_or_exit
    input
    until valid_input?("exit", "back")
      invalid_input
      input
    end
  end

  def find_or_create_details(address)
    property = Scraper.find_property(address)
    return unless property.description.nil?

    Scraper.scrape_home_facts(@user_input)
    Scraper.scrape_price_insights(@user_input)
  end

  def details_display(address)
    property = Scraper.find_property(address)
    description_and_details(property)
  end

  def price_insights(address)
    see_price_insights?(@user_input)
    input
    until valid_input?("yes", "no", "y", "n")
      invalid_input
      input
    end
    return unless @user_input == "yes" || @user_input == "y"

    price_insights_display(address)
  end

  def price_insights_display(address)
    property = Scraper.find_property(address)
    price_insights(property)
  end

  def valid_input?(*input)
    input.any? { |word| word == @user_input }
  end

  def user_input_exit?
    @user_input.casecmp("exit").zero?
  end

  def user_input_back?
    @user_input.casecmp("back").zero?
  end
end
