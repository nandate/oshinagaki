class MenusController < ApplicationController
  def show
    @menu = Menu.find(params[:id])
  end

  def create
    user = User.find(params[:id])
    @menu = user.menus.create(menu_params)
    if @menu.save
      render json: @menu, status: 201
    else
      @feed_items = []
      render json: @menu.errors, status: 422
    end
  end

  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy
    render :json => { :menu => @menu }
  end

  private
    def menu_params
      params.require(:menu).permit(:content,:image_url,:author)
    end

end
