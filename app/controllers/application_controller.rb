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
  end

  def get_group(groupcode)
    Group.get_from_cache(groupcode)
  end

  def isApi
    params[:api] == "YES"
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
      return true
    else
      return false
    end
  end

  def createGroup(name, desc)
    @group = Group.new(group_params)

    @group.name = name
    @group.desc = desc

    code = SecureRandom.hex(4)

    # No congelara el servidor, no?

    while Group.find_by_code(code)
      code = SecureRandom.hex(4)
    end

    @group.code = code

    @group.save
    return @group
  end

  def renderResponse(res, response, view)
    if isApi
      renderJson(res)
    else
      flash.now[:alert] = response
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
