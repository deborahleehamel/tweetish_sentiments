class FriendsController < ApplicationController
  def show
    @friends = twitter.get_friends
  end

  private

    def twitter
      @twitter ||= TwitterService.new(current_user)
    end
end
