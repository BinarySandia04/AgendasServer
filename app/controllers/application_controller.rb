class ApplicationController < ActionController::Base
  require 'json'

  helper_method :current_user
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def renderJson(theJson)
    respond_to do |format|
      format.html { render json: theJson}
      format.json { render json: theJson}
    end
  end

  def createUser (email, username, password)
    @user = User.new

    @user.email = email
    @user.password = password
    @user.username = username

    if @user.save
      puts "User digested password: " + @user.password_digest
      return true
    else
      return false
    end
  end
end
