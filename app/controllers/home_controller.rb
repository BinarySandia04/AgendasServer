class HomeController < ApplicationController
  def index
    @user = current_user
  end

  def news
    @user = current_user
  end

  def contact
    @user = current_user
  end
end
