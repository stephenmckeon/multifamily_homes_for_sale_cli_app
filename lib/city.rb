class City
  attr_reader :name, :link

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

  class << self
    def all
      @@all
    end

    def find_city(name)
      all.find { |city| city.name == name }
    end

    def find_or_create_cities
      Scraper.scrape_cities if City.all.empty?
    end
  end
end
