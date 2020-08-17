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

  def invite
    @group = get_group(params[:groupcode])
  end

  def invite_post
    @group = get_group(params[:groupcode])
    @email = params[:invitation_email]
    puts @email

    flash.now[:green] = @email
    render "/group/view/" + @group.code + "/overview"
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

  private
  def create_invitation
    @invitation = Invitation.new()
  end

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
