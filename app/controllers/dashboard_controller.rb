class DashboardController < ApplicationController
  def show
    # @tweets  = twitter.get_tweets
    # @friends = twitter.get_friends
    @sentiment = SentimentService.new.get_sentiment
    require "pry"; binding.pry
  end

  private

    def twitter
      @twitter ||= TwitterService.new(current_user)
    end
end
