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
    if isApi
      if @user.nil?
        renderJson("UNAUTHORIZED")
      else
        assigments = @user.assigments
        finalList = Array.new(0)
        i = 0
        assigments.each do |assigment|
          task = assigment.task
          category = task.category
          completed_by = Assigment.where(task_id: task.id).where(is_done: true).size
          finalList[i] = {"title" => task.title, "task_id" => task.id, "assigment_id" => assigment.id,
                          "desc" => task.desc, "start" => task.start, "duration" => task.duration,
                          "completed" => assigment.is_done, "completed_by" => completed_by,
                          "category_name" => category.name, "category_color" => category.accentcolor,
                          "task_creator_name" => task.user.username, "task_creator_id" => task.user.id,
                          "group_name" => task.group.name}
          if task.file.attached?
            finalList[i]["file"] = url_for(task.file)
            finalList[i]["file_name"] = task.file.blob.filename
          end
          i = i + 1
        end
        renderJson(finalList)
      end
    else
      if @user.nil?
        redirect_to root_url
      end
    end
  end

  def calendar
    @user = current_user
    if @user.nil?
      redirect_to root_url
    end
  end
end
