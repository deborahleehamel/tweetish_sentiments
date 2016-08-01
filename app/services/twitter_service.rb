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

  def get_tweets(user = current_user.screen_name)
    client.user_timeline(user).take(10).map do |tweet|
      [tweet.text, sentiment.get_sentiment(tweet.text)]
    end
  end

  def get_friends
    client.friends(user).take(20).map do |friend|
      [friend.screen_name, friend.profile_image_url.to_s]
    end
  end

  private

    def sentiment
      @sentiment ||= SentimentService.new
    end
end
