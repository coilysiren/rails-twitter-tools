class TwitterClient
  cattr_accessor :REST

  # user = TwitterClient.create_user(User.find(1))
  def self.create_user(user)
    Twitter::REST::Client.new do |config|
      config.consumer_key        = TwitterClient.REST.consumer_key
      config.consumer_secret     = TwitterClient.REST.consumer_secret
      config.access_token        = user.user_key
      config.access_token_secret = user.user_secret
    end
  end

end

TwitterClient.REST = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['twitter_consumer_key']
  config.consumer_secret     = ENV['twitter_consumer_secret']
  config.access_token        = ENV['twitter_access_token']
  config.access_token_secret = ENV['twitter_access_token_secret']
end
