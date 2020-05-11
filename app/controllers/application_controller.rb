class ApplicationController < ActionController::API
  require 'json'

  def getLoginInfo
    return JSON.parse(params[:linfo])
  end

  def login(username, email, password)
    if(not username.nil?)
      myUser = User.where(username: username).first
      if(not myUser.nil?)
        # Try to autentificate with username
        if(myUser.authenticate(password))
          return "OK"
        else
          return "ERROR_WRONG_PASSWORD"
        end
      else
        return "ERROR_USERNAME_DOESNT_EXISTS"
      end
    elsif(not email.nil?)
      myUser = User.where(email: email).first
      if(not myUser.nil?)
        # Try to autentificate with username
        if(myUser.authenticate(password))
          return "OK"
        else
          return "ERROR_WRONG_PASSWORD"
        end
      else
        return "ERROR_EMAIL_DOESNT_EXISTS"
      end
    else
      return "ERROR_NO_PARAMS"
    end
  end

  def renderJson(theJson)
    respond_to do |format|
      format.html { render json: theJson}
      format.json { render json: theJson}
    end
  end
end
