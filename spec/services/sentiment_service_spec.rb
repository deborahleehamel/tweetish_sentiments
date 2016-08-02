require 'rails_helper'

describe SentimentService do
  before do
    @service = SentimentService.new
  end

  it "returns sentiment for text" do
    VCR.use_cassette("get_sentiment") do
      text = "I love this"

      results = @service.get_sentiment(text)

      expect(results[0]).to eq "Positive"
    end
  end

end
