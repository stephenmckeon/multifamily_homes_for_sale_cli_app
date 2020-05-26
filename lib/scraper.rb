require_relative "./Modules/check.rb"

class Scraper
  extend Check

  BASE_URL = "https://www.redfin.com/county/1898/" \
             "NJ/Gloucester-County".freeze

  class << self
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
        Property.new(
          address: home.css(".addressDisplay").text,
          city: city,
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

    def scrape_home_details(address)
      Scraper.scrape_prep(address)
      @property.add_home_details(
        description: @link.css("#marketing-remarks-scroll").text,
        year_built: @year_built,
        lot_size: @lot_size,
        time_on_market: @time_on_market,
        est_price: @est_price,
        est_mo_payment: @est_mo_payment,
        price_sqft: @price_sqft
      )
    end

    def scrape_prep(address)
      @property = Property.find_property(address)
      @link = home_info_link(address)
      @home_details = @link.css(".keyDetailsList span.content")
      year_built_check
      lot_size_check
      time_on_market_check
      est_price_check
      est_mo_payment_check
      price_sqft_check
    end

    def home_info_link(address)
      home = Property.find_property(address)
      Nokogiri::HTML(HTTParty.get(home.link).body)
    end
  end
end
