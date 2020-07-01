class ApplicationController < ActionController::Base
  require 'json'
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  helper_method :current_user
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
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

  def createUser (email, username, password)
    @user = User.new(user_params)

    @user.email = email
    @user.password = password
    @user.username = username
    @user.displayname = username

    if @user.save
      puts "User digested password: " + @user.password_digest
      return true
    else
      return false
    end
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
    params.permit(:avatar)
  end
end
