class SessionsController < ApplicationController
  def logout
    session[:user_id] = nil
    redirect_to root_url
  end

  def create
    usermail = params[:usermail]
    password = params[:password]
    myUser = nil

    if usermail == "" or password == ""
      renderResponse("You can't leave empty fields", "login_view")
      return
    end
    if usermail.include? "@"
      myUser = User.where(email: usermail).first
    else
      myUser = User.where(username: usermail).first
    end

    if myUser.nil?
      renderResponse("This user doesn't exist", "login_view")
      return
    else
      if myUser.authenticate(password)
        session[:user_id] = myUser.id
        redirect_to root_url
      else
        renderResponse("Wrong password", "login_view")
      end
    end
  end

  def register
    username = params[:username]
    email = params[:email]
    password = params[:password]
    confirmation = params[:confirmation]

    if username == "" or password == "" or email == ""
      renderResponse("You can't leave empty fields", "register_view")
      return
    end

    if password != confirmation
      renderResponse("Password mismatch", "register_view")
      return
    end

    if password == username
      renderResponse("Your password can't be your username", "register_view")
      return
    end

    if password.length > 16
      renderResponse("Password is too long. Make your password between 6 and 16 characters", "register_view")
      return
    elsif password.length < 6
      renderResponse("Password is too short. Make your password between 6 and 16 characters", "register_view")
      return
    end

    if User.where(username: username).exists?
      renderResponse("This username is already taken", "register_view")
      return
    elsif User.where(email: email).exists?
      renderResponse("This email already belongs to an account", "register_view")
      return
    else
      if createUser(email, username, password)
        session[:user_id] = User.where(username: username).first.id
        redirect_to root_url
      else
        renderResponse("Error", "register_view")
        return
      end
    end
  end

  protected
  def renderResponse(response, view)
    flash.now[:alert] = response
    render view
  end
end
