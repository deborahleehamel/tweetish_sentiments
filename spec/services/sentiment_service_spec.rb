require 'rails_helper'

describe SentimentService do
  before do
    @service = SentimentService.new
  end

  it "returns tweets from home timeline" do
    VCR.use_cassette("get_sentiment") do
      text = "@jbaseball44 the things we do for love"

      results = @service.get_sentiment(text)

      expect(results).to be "Negative"
    end
  end

end
