class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @menus = @user.menus
  end
end
