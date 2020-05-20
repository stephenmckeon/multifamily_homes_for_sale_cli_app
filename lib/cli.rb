# This class is responsible for communication with the user
# This is where I will use 'puts'
# This will never use nokogiri
# This will invoke Scraper

class Cli
  # --IDEAS--
  # select a market to search after welcome message
  ## have a profile setup with password that knows your default seach area
  ## have guest profile with no password that makes you select an area to search

  def call
    Scraper.new.scrape_listings
    load_users
    login
    Message.welcome_message
    start
  end

  def load_users
    User.new(name: "Steve", username: "stephenmckeon", password: "love2code")
  end

  def login
    print "Welcome to the CLI property search. Please login to continue:".blue
    puts
    print "Username: ".yellow
    @username = gets.chomp
    print "Password: ".yellow
    @password = gets.chomp
    if User.verify_account(@username, @password)
      Message.login_success
    else
      Message.login_fail
    end
  end

  def start(to_exit = true)
    display_properties
    Message.prompt_user
    continue
    Message.exit if to_exit
  end

  def display_properties
    puts
    Property.all.each do |home|
      puts "‣ " + home.address.bold.underline
      puts "  ➼ #{home.price}".green
      puts "  ➼ #{home.beds}"
      puts "  ➼ #{home.baths}"
      puts "  ➼ #{home.sqft}"
      puts
      sleep 0.3
    end
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

    Message.invalid_address
    continue
    true
  end

  def display_details
    find_or_create_details(@user_input)
    details_display(@user_input)
    price_insights(@user_input)
    Message.back_or_exit
    input
    until valid_input?("exit", "back")
      Message.invalid_input
      input
    end
  end

  def find_or_create_details(address)
    prop = Scraper.find_property(address)
    return unless prop.description.nil?

    Scraper.scrape_home_facts(@user_input)
    Scraper.scrape_price_insights(@user_input)
  end

  def details_display(address)
    prop = Scraper.find_property(address)
    Message.description
    puts prop.description.blue
    puts
    puts "Year Built: ".bold + prop.year_built + \
         "     Lot Size: ".bold + prop.lot_size + \
         "     Time on Market: ".bold + prop.time_on_market
    puts
  end

  def price_insights(address)
    see_price_insights?
    input
    until valid_input?("yes", "no", "y", "n")
      Message.invalid_input
      input
    end
    price_insights_display(address) if @user_input == "yes" || @user_input == "y"
  end

  def see_price_insights?
    puts "Would you like to see " + "price insights ".green + \
         "for " + @user_input.yellow + "?"
    puts "(type " + "'yes'".white.on_green + " or " + "'no')".white.on_red
    puts
  end

  def price_insights_display(address)
    prop = Scraper.find_property(address)
    puts
    puts prop.est_mo_payment
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
