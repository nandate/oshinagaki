class HomesController < ApplicationController
  def top
    if logged_in?
      @menu = current_user.menus.build
      @feed_items = current_user.feed
    end
  end

end
