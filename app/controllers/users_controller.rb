class UsersController < ApplicationController
  def show
    @tweets  = twitter.get_tweets(current_user.screen_name)
  end

  def show_friend_tweets
    @tweets = twitter.get_tweets(params[:user][0])
    @friend = params[:user]
  end

  private

    def twitter
      @twitter ||= TwitterService.new(current_user)
    end
end
