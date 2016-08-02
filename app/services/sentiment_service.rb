class SentimentService

  def initialize
    @conn = Faraday.new(:url => 'https://jamiembrown-tweet-sentiment-analysis.p.mashape.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def get_sentiment(text = "I love Ioanna")
    response = @conn.get do |req|
      req.url '/api/'
      req.params['text'] = text
        req.headers['X-Mashape-Key'] = ENV['MASHAPE_KEY']
      req.headers['Accept'] = 'application/json'
    end
    sentiment = normalize_sentiment(parse(response))
    [sentiment["sentiment"], (sentiment["score"] * 100.00)]
  end

  def normalize_sentiment(sentiment)
    sentiment["sentiment"] = "Positive" if sentiment["sentiment"] == "positiive"
    sentiment["sentiment"] = "Negative" if sentiment["sentiment"] == "negative"
    sentiment["sentiment"] = "Neutral"  if sentiment["sentiment"] == "neutral"
    sentiment
  end


  private

    def parse(response)
      JSON.parse(response.env.body)
    end
end
