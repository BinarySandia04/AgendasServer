class TaskController < ApplicationController
  def create
    @user = current_user
    @group = get_group(params[:groupcode])

    if @group.nil?
      flash[:red] = "Error"
      redirect_to root_url
      return
    end

    unless @group.users.exists?(@user.id)
      flash[:red] = "Error"
      redirect_to root_url
      return
    end
  end

  def view
    @user = current_user
    @task = Task.find(params[:taskcode])

    if @task.nil? or @user.nil?
      redirect_to root_url
    else
      unless @user.assigments.exists?(task: @task)
        redirect_to root_url
      else
        @assigment = Assigment.where(user: @user, task: @task).first
      end
    end
  end

  def create_post
    @user = current_user
    @group = get_group(params[:groupcode])
    title = params[:title]
    desc = params[:desc]
    day = params[:day]
    start_h = params[:start_h]
    start_m = params[:start_m]
    duration_h = params[:duration_h]
    duration_m = params[:duration_m]

    # Verificacion
    if title == ""
      flash.now[:red] = "Has d'introduïr un títol"
      render 'task/create'
      return
    end

    category = params[:category] # String del nombre

    unless Category.where(group_id: @group.id, name: category).present?
      flash.now[:red] = "Has d'introduir una categoria vàlida"
      render 'task/create'
      return
    end

    category_object = Category.where(group_id: @group.id, name: category).first

    @task = Task.new()

    # Usuario categoria y eso
    @task.category = category_object
    @task.user = @user
    @task.group = @group
    @task.title = title
    @task.desc = desc

    # Calcular timepo de incio parseando el string del html
    datedata = day.split('-')
    datedata.each_with_index do |value, index|
      datedata[index] = value.to_i
    end
    @task.start = DateTime.new(datedata[0], datedata[1], datedata[2], start_h.to_i, start_m.to_i, 0)

    # Y ahora la duracion
    @task.duration = duration_h.to_i * 60 + duration_m.to_i

    if @task.save
      # Crear assigments
      Assigment.create_auto(@task)
      Assigment.notify_users(@task, @user, @user.username + " ha creat la tasca " + title, desc)

      flash[:green] = "S'ha creat la tasca correctament!"
      redirect_to '/group/view/' + params[:groupcode] + '/overview'
    else
      flash[:red] = "Error"
      redirect_to root_url
    end

    # TODO: Coses
  end

  def completed
    @user = current_user
    @task = Task.find(params[:taskcode])

    @user = current_user
    @task = Task.find(params[:taskcode])

    if @task.nil? or @user.nil?
      redirect_to root_url
    else
      unless @user.assigments.exists?(task: @task)
        redirect_to root_url
      else
        @assigment = Assigment.where(task: @task, user: @user).first
        unless @assigment.is_done
          @assigment.is_done = true
          @assigment.save()
          flash.now[:green] = "Has marcat la tasca com a completeda"
          render 'task/view'
        else
          flash.now[:red] = "Error"
          render 'task/view'
        end
      end
    end
  end
end
