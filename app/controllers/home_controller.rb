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

  def notifications
    @user = current_user
    if @user.nil?
      redirect_to root_url
    end
  end
end
