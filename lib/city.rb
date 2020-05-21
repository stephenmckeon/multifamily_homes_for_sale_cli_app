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
end
