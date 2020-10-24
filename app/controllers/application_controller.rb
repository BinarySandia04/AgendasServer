class ApplicationController < ActionController::Base
  require 'json'
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  helper_method :current_user
  def current_user
    if session[:user_id]
      @current_user = User.get_from_cache(session[:user_id])
    else
      @current_user = nil
    end

    if @current_user
      @notifications = @current_user.notifications.count
    end


    return @current_user
  end

  def get_group(groupcode)
    return Group.get_from_cache(groupcode)
    # Group.find_by_code(code)
  end

  def isApi
    params[:api] == "YES"
    #true
  end

  def renderJson(theJson)
    respond_to do |format|
      format.html { render json: theJson}
      format.json { render json: theJson}
    end
  end

  def createUser (email, username, password, name, surname, birthdate)
    @user = User.new(user_params)

    @user.email = email
    @user.password = password
    @user.username = username
    @user.displayname = username
    @user.name = name
    @user.surname = surname
    @user.birthdate = birthdate
    @user.role = "user"

    if @user.save
      UserMailer.registration_confirmation(@user).deliver

      return true
    else
      return false
    end
  end

  def createGroup(name, desc, creator_id)
    @group = Group.new(group_params)

    @group.name = name
    @group.desc = desc
    @group.creator_id = creator_id

    code = SecureRandom.hex(4)

    # No congelara el servidor, no?

    while Group.find_by_code(code)
      code = SecureRandom.hex(4)
    end

    @group.code = code

    @group.save
    return @group
  end

  def renderResponse(res, response, view, flashresponse)
    if isApi
      renderJson(res)
    else
      if flashresponse == "red"
        flash.now[:red] = response
      elsif flashresponse == "green"
        flash.now[:green] = response
      else
        flash.now[:alert] = response
      end
      render view
    end
  end

  private
  def user_params
    params.permit(:avatar, :email, :username, :displayname, :name, :surname, :birthdate, :role, :description)
  end

  def group_params
    params.permit(:name, :desc)
  end
end
