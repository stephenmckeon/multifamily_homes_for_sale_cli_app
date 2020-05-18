# This is responsible for scraping my webpage(s)
# This file will use nokogiri, i.e. scrape
# This file will never use 'puts'

require "./config/environment"

class Scraper
  def self.scrape_listings_page(listings_url)
    html = Nokogiri::HTML(HTTParty.get(listings_url))
    homecards = html.css(".HomeCardContainer")

    properties = []

    homecards.each do |home|
      properties << {
        address: home.css(".addressDisplay").text,
        price: home.css(".homecardV2Price").text,
        beds: home.css(".stats")[0].text,
        baths: home.css(".stats")[1].text,
        sqft: home.css(".stats")[2].text,
        link: "https://www.redfin.com" + home.css(".scrollable a").attribute("href").value,
      }
    end
    properties
  end
end

listings_url = "https://www.redfin.com/city/19265/NJ/Vineland/filter/property-type=multifamily"
puts Scraper.scrape_listings_page(listings_url)