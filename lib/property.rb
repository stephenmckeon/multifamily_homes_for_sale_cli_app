class Property
  attr_reader :address, :city, :price, :beds, :baths, :sqft, :link, :ascii_art
  attr_accessor :description, :year_built, :lot_size, :time_on_market,
                :est_price, :est_mo_payment, :price_sqft

  @@all = []

  def initialize(address:, city:, price:, beds:, baths:, sqft:, link:)
    @address = address.split(", ")[0]
    @city = city
    @price = price
    @beds = beds
    @baths = baths
    @sqft = sqft
    @link = "https://www.redfin.com" + link
    @ascii_art = "./lib/Ascii Art/AsciiArt" + rand(1..5).to_s
    @@all << self
  end

  def add_home_details(description:, year_built:, lot_size:, time_on_market:,
                       est_price:, est_mo_payment:, price_sqft:)
    @description = description
    @year_built = year_built
    @lot_size = lot_size
    @time_on_market = time_on_market
    @est_price = est_price
    @est_mo_payment = est_mo_payment
    @price_sqft = price_sqft
  end

  class << self
    def all
      @@all
    end

    def find_property(address)
      Property.all.find { |home| home.address == address }
    end

    def find_or_scrape_properties(city_name)
      city = City.find_city(city_name)
      Scraper.scrape_listings(city) if city.properties.empty?
    end

    def find_or_create_details(address)
      property = Property.find_property(address)
      return unless property.description.nil?

      Scraper.scrape_home_details(address)
    end
  end
end
