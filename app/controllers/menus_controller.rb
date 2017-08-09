class MenusController < ApplicationController
  def create
    user = User.find(params[:id])
    @menu = user.menus.create(menu_params)
    if @menu.save
      render json: @menu, status: 201
    else
      render json: @menu.errors, status: 422
    end
  end

  def destroy
  end

  private
  def menu_params
    params.require(:menu).permit(:content,:image_url,:author)
  end

end
