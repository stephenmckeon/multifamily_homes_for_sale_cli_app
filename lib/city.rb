class City
  attr_accessor :name, :link

  @@all = []

  def initialize(name:, link:)
    @name = name
    @link = "https://www.redfin.com" + link + \
            "/filter/property-type=multifamily"
    @@all << self
  end

  def properties
    Property.all.select do |property|
      property.city == self
    end
  end

  def self.all
    @@all
  end

  def self.find_city(name)
    all.find { |city| city.name == name }
  end

  def self.find_or_create_cities
    Scraper.scrape_cities if City.all.empty?
  end
end
