class SentimentService

  def initialize
    @conn = Faraday.new(:url => 'https://jamiembrown-tweet-sentiment-analysis.p.mashape.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def get_sentiment(text = "I love Nick")
    response = @conn.get do |req|
      req.url '/api/'
      req.params['text'] = text
      req.headers['X-Mashape-Key'] = ENV['MASHAPE_KEY']
      req.headers['Accept'] = 'application/json'
    end
    sentiment = parse(response)
    # require "pry"; binding.pry
    "Sentiment is #{sentiment["sentiment"]} with a score of #{sentiment["score"] * 100.00}%"
  end


  private

    def parse(response)
      JSON.parse(response.env.body)
    end
end
