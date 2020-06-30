class SessionsController < ApplicationController
  def logout
    session[:user_id] = nil
    redirect_to root_url
  end

  def register_view
    unless session[:user_id].nil?
      if params[:api] == "YES"
        renderJson("ALREADY_LOGGED_IN")
      else
        redirect_to root_url
      end
    end
  end

  def login_view
    unless session[:user_id].nil?
      if params[:api] == "YES"
        renderJson("ALREADY_LOGGED_IN")
      else
        redirect_to root_url
      end
    end
  end
  def create
    usermail = params[:usermail]
    password = params[:password]
    myUser = nil

    if usermail == "" or password == ""
      renderResponse("ERROR_NO_PARAMS", "You can't leave empty fields", "login_view")
      return
    end
    if usermail.include? "@"
      myUser = User.where(email: usermail).first
    else
      myUser = User.where(username: usermail).first
    end

    if myUser.nil?
      renderResponse("ERROR_USERMAIL_DOESNT_EXISTS", "This user doesn't exist", "login_view")
      return
    else
      if myUser.authenticate(password)
        if params[:api] == "YES"
          renderJson("OK")
        else
          session[:user_id] = myUser.id
          redirect_to root_url
        end
      else
        renderResponse("ERROR_WRONG_PASSWORD", "Wrong password", "login_view")
      end
    end
  end

  def register
    username = params[:username]
    email = params[:email]
    password = params[:password]
    confirmation = params[:confirmation]

    if username == "" or password == "" or email == ""
      renderResponse("ERROR_NO_PARAMS", "You can't leave empty fields", "register_view")
      return
    end

    if password != confirmation
      renderResponse("ERROR_CONFIRMATION","Password mismatch", "register_view")
      return
    end

    if password == username
      renderResponse("ERROR_PASS_EQUALS_USER","Your password can't be your username", "register_view")
      return
    end

    if password.length > 16
      renderResponse("ERROR_PASSWORD_LONG", "Password is too long. Make your password between 6 and 16 characters", "register_view")
      return
    elsif password.length < 6
      renderResponse("ERROR_PASSWORD_SHORT", "Password is too short. Make your password between 6 and 16 characters", "register_view")
      return
    end

    if User.where(username: username).exists?
      renderResponse("ERROR_USERNAME_ALREADY_EXISTS", "This username is already taken", "register_view")
      return
    elsif User.where(email: email).exists?
      renderResponse("ERROR_EMAIL_TAKEN", "This email already belongs to an account", "register_view")
      return
    else
      if createUser(email, username, password)
        if params[:api] == "YES"
          renderJson("OK")
        else
          session[:user_id] = User.where(username: username).first.id
          redirect_to root_url
        end
      else
        renderResponse("ERROR", "Error", "register_view")
        return
      end
    end
  end

  protected
  def renderResponse(res, response, view)
    if params[:api] == "YES"
      renderJson(res)
    else
      flash.now[:alert] = response
      render view
    end
  end
end
