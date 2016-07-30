class DashboardController < ApplicationController
  def show
    # @tweets  = twitter.get_tweets
    # @friends = twitter.get_friends
  end

  private

    def twitter
      @twitter ||= TwitterService.new(current_user)
    end
end
