# This is responsible for scraping my webpage(s)
# This file will use nokogiri, i.e. scrape
# This file will never use 'puts'

class Scraper
  attr_accessor :listings_url

  BASE_URL = "https://www.redfin.com/county/1898/" \
             "NJ/Gloucester-County".freeze

  def scrape_cities
    city_url.each do |city|
      City.new(
        name: city.text,
        link: city.attribute("href").value
      )
    end
  end

  def city_url
    html = Nokogiri::HTML(HTTParty.get(BASE_URL).body)
    html.css(".ContextualInterlinksTable")[1].css("table a")
  end

  def scrape_listings(city)
    homecards(city).each do |home|
      city.properties << Property.new(
        address: home.css(".addressDisplay").text,
        price: home.css(".homecardV2Price").text,
        beds: home.css(".stats")[0].text,
        baths: home.css(".stats")[1].text,
        sqft: home.css(".stats")[2].text,
        link: home.css(".scrollable a").attribute("href").value
      )
    end
  end

  def homecards(city)
    html = Nokogiri::HTML(HTTParty.get(city.link).body)
    html.css(".HomeCardContainer")
  end

  def self.scrape_home_details(address)
    Scraper.scrape_prep(address)
    @property.add_home_details(
      description: @link.css("#marketing-remarks-scroll").text,
      year_built: @year_built,
      lot_size: @lot_size,
      time_on_market: @time_on_market,
      est_price: @est_price,
      est_mo_payment: @home_details[1].text,
      price_sqft: @home_details[3].text
    )
  end

  def self.scrape_prep(address)
    @property = find_property(address)
    @link = home_info_link(address)
    @home_details = @link.css(".keyDetailsList span.content")
    lot_size_check
    year_built_check
    time_on_market_check
    est_price_check
  end

  def self.year_built_check
    year_built = @home_details.find do |item|
      text = item.text
      (text.start_with?("18") && text.length == 4) ||
        (text.start_with?("19") && text.length == 4) ||
        (text.start_with?("20") && text.length == 4)
    end
    @year_built = year_built.nil? ? "-- " : year_built.text
  end

  def self.lot_size_check
    lot_size = @home_details.find do |item|
      item.text.include?("Sq. Ft.") || item.text.include?("Acre")
    end
    @lot_size = lot_size.nil? ? "-- " : lot_size.text
  end

  def self.time_on_market_check
    time_on_market = @home_details.find do |item|
      item.text.include?("day")
    end
    @time_on_market = time_on_market.nil? ? "-- " : time_on_market.text
  end

  def self.est_price_check
    est_price = nil
    if @home_details[2].text.length.between?(7, 8)
      est_price = @home_details[2].text
    end
    @est_price = est_price.nil? ? "--      " : est_price
  end

  def self.home_info_link(address)
    home = find_property(address)
    Nokogiri::HTML(HTTParty.get(home.link).body)
  end

  def self.find_city(name)
    City.all.find { |city| city.name == name }
  end

  def self.find_property(address)
    Property.all.find { |home| home.address == address }
  end
end
