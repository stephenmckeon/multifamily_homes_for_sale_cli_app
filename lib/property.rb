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
    @address = address
    @price = price
    @beds = beds
    @baths = baths
    @sqft = sqft
    @link = "https://www.redfin.com" + link
    @@all << self
  end

  def self.all
    @@all
  end
end
