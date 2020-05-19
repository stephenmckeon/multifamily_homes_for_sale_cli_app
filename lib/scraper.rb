# This is responsible for scraping my webpage(s)
# This file will use nokogiri, i.e. scrape
# This file will never use 'puts'

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

  def self.scrape_home_facts(address)
    prop = find_property(address)
    link = home_info_link(address)
    home_details = link.css(".keyDetailsList span.content")
    prop.add_home_facts(
      description: link.css("#marketing-remarks-scroll").text,
      year_built: home_details[6].text,
      lot_size: home_details.find do |item|
        item.text.include?("Sq. Ft.") || item.text.include?("Acre")
      end.text,
      time_on_market: home_details[5].text
    )
  end

  def self.scrape_price_insights(address)
    prop = find_property(address)
    link = home_info_link(address)
    home_details = link.css(".keyDetailsList span.content")
    prop.add_price_insights(
      est_price: home_details[2].text,
      est_mo_payment: home_details[1].text,
      price_sqft: home_details[3].text
    )
  end

  def self.home_info_link(address)
    home = find_property(address)
    Nokogiri::HTML(HTTParty.get(home.link).body)
  end

  def self.find_property(address)
    Property.all.find { |home| home.address == address }
  end
end
