class User
  attr_reader :name, :username, :password, :market, :birthday

  @@all = []

  def initialize(name:, username:, password:, market:, birthday:)
    @name = name
    @username = username
    @password = password
    @market = market
    @birthday = birthday
    @@all << self
  end

  class << self
    def all
      @@all
    end

    def find_user_by_username(username)
      all.find { |account| account.username == username }
    end

    def verify_account(username, password)
      user = find_user_by_username(username)
      return if user.nil?

      user.password == password
    end
  end
end
