class User
  attr_accessor :name, :username, :password

  @@all = []

  def initialize(name:, username:, password:)
    @name = name
    @username = username
    @password = password
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_user_by_username(username)
    all.find { |account| account.username == username }
  end

  def self.verify_account(username, password)
    user = find_user_by_username(username)
    return if user.nil?

    user.password == password
  end
end
