class GroupController < ApplicationController
  def create
    @user = current_user
  end

  def create_post
    @user = current_user
    if @user
      @group = createGroup(params[:name], params[:desc])
      @group.users << @user

      if isApi
        renderJson("OK")
      else
        redirect_to "/group/view/" + @group.code
      end
    else
      redirect_to root_url
    end
  end

  def view
    @user = current_user
    @group = Group.find_by_code(params[:groupcode])

    if @user
      unless @group
        # TODO: Hacer redirect al buscador y no a root_url
        redirect_to root_url
      end
    else
      redirect_to root_url
    end
  end

  def join
    @user = current_user
    redirect_to root_url unless @user
  end

  def join_post
    @user = current_user
    @group = get_group(params[:groupcode])
    redirect_to root_url unless @user

    if @group
      redirect_to "/group/view/" + @group.code
    else
      flash.now[:alert] = "No s'ha trobat ningun grup. Asegurat de que el codi que has introduït és correcte"
      render "/group/join"
    end
  end
end
