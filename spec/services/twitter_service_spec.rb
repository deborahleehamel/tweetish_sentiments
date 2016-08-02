require 'rails_helper'

describe TwitterService do
  before do
    @user = User.create(screen_name: "dhamel",
                       uid: "546612",
                       token: ENV["TWITTER_ACCESS_TOKEN"],
                       secret: ENV["TWITTER_ACCESS_TOKEN_SECRET"])
    @service = TwitterService.new(@user)
  end

  it "returns tweets from user timeline" do
    VCR.use_cassette("user_timeline") do
      tweets = @service.get_tweets
      tweet  = tweets.first
      expect(tweets.count).to eq 10
      expected_text = "RT @HeaphyDarren: I love this talk from David Snowden (@snowded) on Complexity Informed Design Thinking at LeanWX '16 https://t.co/k1Y94Ta0…"
      expect(tweet[0]).to eq expected_text
    end
  end

end
