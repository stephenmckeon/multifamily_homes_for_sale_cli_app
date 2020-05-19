class User
  attr_accessor :name, :user_name, :password

  @@all = []

  def initialize(name:, user_name:, :password:)
    @name = name
    @user_name = user_name
    @password = password
    @@all << self
  end

  def self.all
    @@all
  end
end