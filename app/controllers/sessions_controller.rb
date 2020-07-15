class SessionsController < ApplicationController
  def logout
    session[:user_id] = nil
    redirect_to root_url
  end

  def register_view
    @hide_user = true
    unless session[:user_id].nil?
      if isApi
        renderJson("ALREADY_LOGGED_IN")
      else
        redirect_to root_url
      end
    end
  end

  def confirm
    user = User.where(confirm_token: params[:confirm_token]).first
    if user
      user.activate_email
      flash[:alert] = "Success confirming email!"
      redirect_to login_url
    else
      redirect_to root_url
    end
  end

  def login_view
    @hide_user = true
    unless session[:user_id].nil?
      if isApi
        renderJson("ALREADY_LOGGED_IN")
      else
        redirect_to root_url
      end
    end
  end
  def create
    @hide_user = true

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
        if myUser.email_confirmed
          if isApi
            renderJson("OK")
          else
            session[:user_id] = myUser.id
            redirect_to root_url
          end
        else
          renderResponse("ERROR_EMAIL_CONFIRMATION", "Please activate your account following the instructions of the confirmation mail", "login_view")
        end
      else
        renderResponse("ERROR_WRONG_PASSWORD", "Wrong password", "login_view")
      end
    end
  end

  def register
    @hide_user = true

    username = params[:username]
    email = params[:email]
    password = params[:password]
    confirmation = params[:confirmation]

    name = params[:name]
    surname = params[:surname]
    birthdate = params[:birthdate][0]

    if username == "" or password == "" or email == "" or name == "" or surname == "" or birthdate == ""
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
      if createUser(email, username, password, name, surname, birthdate)
        if isApi
          renderJson("EMAIL_SEND")
        else
          @user = User.where(username: username).first.id
          flash[:alert] = "Hem enviat un email de confirmació, mira el teu correu"
          redirect_to '/register'
        end
      else
        renderResponse("ERROR", "Error", "register_view")
        return
      end
    end
  end
end
