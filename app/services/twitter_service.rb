class TwitterService
  attr_reader :client, :user

  #is there a better way by separating this into its own private method for client

  def initialize(user)
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_KEY"]
      config.consumer_secret     = ENV["TWITTER_SECRET"]
      config.access_token        = user.token
      config.access_token_secret = user.secret
    end
    @user = user
  end

  def get_tweets
    client.user_timeline(user.screen_name).map do |tweet|
      tweet.text
    end
  end

  def get_friends
    client.friends(user.screen_name)
  end

  def home_timeline
    client.home_timeline.map do |tweet|
      tweet.text
    end
  end

  def user_timeline(user)
   parse(access_token(user).request(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json?count=50"))
  end


  private

  def access_token(user)
    prepare_access_token(user.token, user.secret)
  end

  def prepare_access_token(oauth_token, oauth_token_secret)
    consumer     = OAuth::Consumer.new(ENV["TWITTER_KEY"],
                                     ENV["TWITTER_API_SECRET"],
                                     { site: "https://api.twitter.com" })
    token_hash   = { oauth_token: oauth_token,
                   oauth_token_secret: oauth_token_secret }
    access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
    return access_token
  end

  def parse(input)
    JSON.parse(input.body, symbolize_names: true)
  end
end
