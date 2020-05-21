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

  def self.scrape_home_facts(address)
    Scraper.scrape_prep(address)
    lot_size_check
    @property.add_home_facts(
      description: @link.css("#marketing-remarks-scroll").text,
      year_built: @home_details[6].text,
      lot_size: @lot_size,
      time_on_market: @home_details[5].text
    )
  end

  def self.scrape_price_insights(address)
    @property.add_price_insights(
      est_price: @home_details[2].text,
      est_mo_payment: @home_details[1].text,
      price_sqft: @home_details[3].text
    )
  end

  def self.scrape_prep(address)
    @property = find_property(address)
    @link = home_info_link(address)
    @home_details = @link.css(".keyDetailsList span.content")
  end

  def self.lot_size_check
    lot_size = @home_details.find do |item|
      item.text.include?("Sq. Ft.") || item.text.include?("Acre")
    end
    @lot_size = lot_size.nil? ? "-- " : lot_size
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
