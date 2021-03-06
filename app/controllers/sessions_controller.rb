class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_back_or user
  end

  def destroy
    session[:user_id] = nil if logged_in?
    redirect_to root_url
  end

end
