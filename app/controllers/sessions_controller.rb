class SessionsController < ApplicationController

  def create
   if user = User.from_omniauth(request.env["omniauth.auth"])
     session[:user_id] = user.id
   end
   redirect_to dashboard_path(current_user.screen_name)
  end

  def destroy
    session.destroy
    redirect_to root_path
  end
end
