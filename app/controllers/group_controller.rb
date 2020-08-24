class GroupController < ApplicationController
  def create
    @user = current_user
  end

  def create_post
    @user = current_user
    if @user
      @group = createGroup(params[:name], params[:desc], @user.id)

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

  def invite_post
    @user = current_user
    @group = get_group(params[:group_code])

    usermail = params[:usermail]

    if @user.get_role(@group) != 1
      flash[:red] = "Error"
      redirect_to root_url # TODO: Testear
      return
    end

    @invited_user = User.get_user_by_usermail(usermail)
    if @invited_user
      # All valido
      unless Invitation.find_by(group_id: @group.id, sender_id: @user.id, recipent_id: @invited_user.id).present?
        Group.invite(@group, @user, @invited_user)
        flash[:green] = "S'ha convidat a " + usermail
        redirect_to '/group/view/' + @group.code + "/administrate" # TODO: Testear
      else
        flash[:red] = "Ja has convidat a aquest usuari!"
        redirect_to '/group/view/' + @group.code + "/administrate" # TODO: Testear
      end
    else
      flash[:red] = "No s'ha trobat a l'usuari"
      redirect_to '/group/view/' + @group.code + "/administrate"
      return
    end
  end

  def edit_members
    group = Group.find(params[:group])
    # TODO: Despues de la migracion hacer esto

    flash[:green] = "S'han actualtzat les propietats dels membres correctament!"
    redirect_to '/group/view/' + group.code + "/administrate"
  end

  def accept_invite
    @user = current_user
    @invitation = Invitation.get_by_id(params[:id])

    if @invitation.recipent_id == @user.id
      @group = Group.get_from_cache_id(@invitation.group_id)
      unless @group.users.exists?(@user.id)
        # Ok for me
        create_membership(@user.id, @group.id, 0)
        @invitation.destroy
        redirect_to "/group/view/" + @group.code + "/overview"
      end
    else
      flash[:red] = "Error"
      puts "HOAOLSSLL"
      redirect_to root_url
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
