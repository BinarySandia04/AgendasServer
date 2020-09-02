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

  def create_post
    @user = current_user
    @group = get_group(params[:groupcode])

    # TODO: Coses
  end
end
