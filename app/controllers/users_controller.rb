class UsersController < ApplicationController
  before_action :logged_in_user

  def show
    @user = User.find(params[:id])
    @menus = @user.menus
  end

  private
    def logged_in_user
      unless logged_in?
        redirect_to root_url
      end
    end

end
