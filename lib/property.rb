# This is responsilbe for the blueprint of a Property
# It will never use nokogiri
# It will never use 'puts'
# It will store all of my property instance data, i.e. attributes

class Property
  # each instance is initiated with an address, price,
  # bds, bas, sqft (default nil)
  attr_accessor :address, :price, :beds, :baths, :sqft, :link

  @@all = []

  def initialize(address:, price:, beds:, baths:, sqft:, link:)
    @address = address.split(", ")[0]
    @price = price
    @beds = beds
    @baths = baths
    @sqft = sqft
    @link = "https://www.redfin.com" + link
    @@all << self
  end

  def add_details(description:, year_built:, lot_size:, time_on_market:)
    @description = description
    @year_built = year_built
    @lot_size = lot_size
    @time_on_market = time_on_market
  end

  def self.all
    @@all
  end
end
