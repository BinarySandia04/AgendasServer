class DashboardController < ApplicationController
  def admin_dashboard
    @user = current_user
    if @user
      unless @user.role == "admin"
        redirect_to root_url
      end
    else
      redirect_to root_url
    end
  end
end
