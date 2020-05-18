# This is responsible for scraping my webpage(s)
# This file will use nokogiri, i.e. scrape
# This file will never use 'puts'

class Scraper
  attr_accessor :listings_url

  # BASE_URL = "https://www.redfin.com/city/19265/NJ/" \
  #            "Vineland/filter/property-type=multifamily".freeze

  BASE_URL = "https://www.redfin.com/city/19265/NJ/Vineland"

  def scrape_listings
    homecards.each do |home|
      Property.new(
        address: home.css(".addressDisplay").text,
        price: home.css(".homecardV2Price").text,
        beds: home.css(".stats")[0].text.gsub("\u2014", "-- "),
        baths: home.css(".stats")[1].text.gsub("\u2014", "-- "),
        sqft: home.css(".stats")[2].text,
        link: home.css(".scrollable a").attribute("href").value,
      )
    end
  end

  def homecards
    html = Nokogiri::HTML(HTTParty.get(BASE_URL))
    html.css(".HomeCardContainer")
  end
end
