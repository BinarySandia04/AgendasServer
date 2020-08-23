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

  def delete_notification
    @user = current_user
    id = params[:id]
    if @user
      begin
        notification = Notification.find(id)
        if notification.user_id == @user.id
          Notification.destroy(id)
          @notifications = @current_user.notifications.count
          render 'home/notifications'
        end
      rescue ActiveRecord::RecordNotFound
        flash[:red] = "Error"
        redirect_to root_url
      end
    else
      flash[:red] = "Error"
      redirect_to root_url
    end
  end
end
