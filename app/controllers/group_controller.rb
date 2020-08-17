class GroupController < ApplicationController
  def create
    @user = current_user
  end

  def create_post
    @user = current_user
    if @user
      @group = createGroup(params[:name], params[:desc])

      @membership = create_membership(@user.id, @group.id, 1)

      if isApi
        renderJson("OK")
      else
        redirect_to "/group/view/" + @group.code
      end
    else
      redirect_to root_url
    end
  end

  def administrate
    @user = current_user
    @group = Group.find_by_code(params[:groupcode])

    unless @user
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
      else
        unless @user.memberships.find_by(group: @group).present?
          redirect_to root_url
        end
      end
    else
      redirect_to root_url
    end
  end

  def join
    @user = current_user
    redirect_to root_url unless @user
  end

  def invite_post
    @user = current_user
    @group = get_group(params[:group_code])

    puts "dddddddddddddddd"
    puts params[:group_code]
    puts "dddddddddddddddd"

    usermail = params[:usermail]

    if @user.get_role(@group) != 1
      flash[:red] = "Error"
      redirect_to root_url # TODO: Testear
      return
    end

    @invited_user = User.get_user_by_usermail(usermail)
    if @invited_user
      # All valido
      Group.invite(@group, @user, @invited_user)
      flash[:green] = "S'ha convidat a " + usermail
      redirect_to '/group/view/' + @group.code + "/administrate" # TODO: Testear
      return
    else
      flash[:red] = "No s'ha trobat a l'usuari"
      puts "D"
      redirect_to '/group/view/' + @group.code + "/administrate" # TODO: Testear
      return
    end
  end

  def join_post
    @user = current_user
    @group = get_group(params[:groupcode])
    redirect_to root_url unless @user

    if @group
      redirect_to "/group/view/" + @group.code + "/overview"
    else
      flash.now[:red] = "No s'ha trobat ningun grup. Asegurat de que el codi que has introduït és correcte"
      render "/group/join"
    end
  end

  def accept_invite
    @user = current_user
    @invitation = Invitation.get_by_id(params[:id])

    if @invitation.recipent_id == @user.id
      @group = get_group(@invitation.group_id)
      unless @group.users.exists?(@user)
        # Ok for me
        create_membership(@user.id, @group.id, 0)
      end
    end
  end

  private
  def create_membership(user_id, group_id, role)
    membership = Membership.new(user_id: user_id, group_id: group_id, role: role)
    if membership.save
      return membership
    else
      if isApi
        renderJson("ERROR")
      else
        redirect_to root_url
      end
    end
  end
end
