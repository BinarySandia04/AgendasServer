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
      if Invitation.find_by(group_id: @group.id, sender_id: @user.id, recipent_id: @invited_user.id).present? || !@group.users.where(id: @invited_user.id).empty?
        flash[:red] = "Ja has convidat a aquest usuari!"
        redirect_to '/group/view/' + @group.code + "/administrate" # TODO: Testear
      else
        Group.invite(@group, @user, @invited_user)
        flash[:green] = "S'ha convidat a " + usermail
        redirect_to '/group/view/' + @group.code + "/administrate" # TODO: Testear
      end
    else
      flash[:red] = "No s'ha trobat a l'usuari"
      redirect_to '/group/view/' + @group.code + "/administrate"
      return
    end
  end

  def edit_members
    group = Group.find(params[:groupcode])
    @user = current_user

    if @user.get_role(group) == 1
      membership = Membership.find(params[:member_id])
      member = membership.user

      membership.role = params[:role]
      if membership.save
        flash[:green] = "Canviat el rol de " + member.username + "!"
        redirect_to '/group/view/' + group.code + "/administrate"
      else
        flash[:red] = "Error"
        redirect_to '/group/view/' + group.code + "/administrate"
      end
    else
      redirect_to root_url
    end
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

  def deny_invite
    @user = current_user
    @invitation = Invitation.get_by_id(params[:id])

    if @invitation.recipent_id = @user.id
      flash.now[:green] = "Has rebutjat la invitació al grup correctament"
      @invitation.destroy
      render 'home/notifications'
    else
      redirect_to root_url
    end
  end

  def exit_group
    @user = current_user
    @group = Group.find_by_code(params[:groupcode])

    # Borrar tasques i membresia. Ah, si ets l'admin admin no pots fer aixo
    if @user.id != @group.creator_id && params[:IKnowWhatAmIDoing] == "1"
      Assigment.where(user: @user, task_id: Task.where(group: @group).pluck(:id)).destroy_all
      Membership.find_by(group: @group, user: @user).destroy
      # Invitation.find_by(group_id: @group.id, recipent_id: @user.id).destroy???

      flash[:green] = "Has sortit de " + @group.name + " correctament."
      redirect_to root_url
    else
      flash[:green] = "Has sortit de " + @group.name + " incorrectament. " + @user.id.to_s + " " + @group.creator_id.to_s
      redirect_to root_url
    end
  end
  def exit_group_confirm
    @user = current_user
    @group_id = params[:groupcode]
  end

  def delete_group
    @user = current_user
    @group = Group.find_by_code(params[:groupcode])

    # Assegurar-nos de que som el legitim creador del grup
    if @user.id == @group.creator_id && params[:IKnowWhatAmIDoing] == "1"
      # 1: Borrar assigments
      Assigment.where(task_id: Task.where(group: @group).pluck(:id)).destroy_all
      # 2: Tasques
      Task.where(group: @group).destroy_all
      # 3: Membresies
      Membership.where(group: @group).destroy_all
      # 4: El grup
      @group.destroy
      flash[:green] = "El grup s'ha borrat correctament."
      redirect_to root_url
    else
      redirect_to root_url
    end
  end
  def delete_group_confirm
    @user = current_user
    @group_id = params[:groupcode]
  end

  private
  def create_membership(user_id, group_id, role)
    membership = Membership.new(user_id: user_id, group_id: group_id, role: role)
    if membership.save
      # Refer tasques bro
      group = get_group(group_id)
      user = User.get_from_cache(user_id)

      Assigment.add_exisiting(user, group)

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
