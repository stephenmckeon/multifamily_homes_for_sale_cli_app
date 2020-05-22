class City
  attr_accessor :name, :link, :properties

  @@all = []

  def initialize(name:, link:)
    @name = name
    @link = "https://www.redfin.com" + link + \
            "/filter/property-type=multifamily"
    @@all << self
    @properties = []
  end

  def self.all
    @@all
  end

  def self.find_city(name)
    all.find { |city| city.name == name }
  end
end
