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
          if notification.deny_action.nil?
            Notification.destroy(id)
            @notifications = @current_user.notifications.count
            render 'home/notifications'
          else
            action = notification.deny_action
            Notification.destroy(id)
            redirect_to action
          end
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

  def accept_notification
    @user = current_user
    id = params[:id]
    if @user
      begin
        notification = Notification.find(id)
        if notification.user_id == @user.id
          if notification.action.nil?
            Notification.destroy(id)
            @notifications = @current_user.notifications.count
            render 'home/notifications'
          else
            action = notification.action
            Notification.destroy(id)
            redirect_to action
          end
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

  def groups
    @user = current_user
    if @user.nil?
      redirect_to root_url
    end
  end

  def tasks
    @user = current_user
    if @user.nil?
      redirect_to root_url
    end
  end

  def calendar
    @user = current_user
    if @user.nil?
      redirect_to root_url
    end
  end
end
