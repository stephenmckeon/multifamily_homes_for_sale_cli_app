# This is responsible for scraping my webpage(s)
# This file will use nokogiri, i.e. scrape
# This file will never use 'puts'

# scrape the details of a home's details -- description, list price, est. price,
# est. mo. payment, price/sqft, time listed, lot size, year built, MLS#

class Scraper
  attr_accessor :listings_url

  BASE_URL = "https://www.redfin.com/city/19265/NJ/Vineland/filter/property-type=multifamily"

  def scrape_listings
    homecards.each do |home|
      Property.new(
        address: home.css(".addressDisplay").text,
        price: home.css(".homecardV2Price").text,
        beds: home.css(".stats")[0].text,
        baths: home.css(".stats")[1].text,
        sqft: home.css(".stats")[2].text,
        link: home.css(".scrollable a").attribute("href").value,
      )
    end
  end

  def homecards
    html = Nokogiri::HTML(HTTParty.get(BASE_URL).body)
    html.css(".HomeCardContainer")
  end

  def self.scrape_property_details(address)
    prop = find_property(address)
    link = home_details(address)
    home_facts = link.css(".keyDetailsList span.content")
    prop.add_details(
      description: link.css("#marketing-remarks-scroll").text,
      year_built: home_facts[6].text,
      lot_size: home_facts.find { |item| item.text.include?("Sq. Ft.") }.text,
      time_on_market: home_facts[5].text
    )
  end

  def self.home_details(address)
    home = find_property(address)
    Nokogiri::HTML(HTTParty.get(home.link).body)
  end

  def self.find_property(address)
    Property.all.find { |home| home.address == address }
  end
end
