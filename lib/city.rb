class City
  attr_accessor :name, :link

  @@all = []

  def initialize(name:, link:)
    @name = name
    @link = "https://www.redfin.com" + link + \
            "/filter/property-type=multifamily"
    @@all << self
  end

  def self.all
    @@all
  end
end
