class ApiController < ApplicationController
  include ActionController::MimeResponds
  protect_from_forgery with: :null_session

  ##########################################################
  # Funciones de rutas
  def register
    name = params[:username]
    email = params[:email]
    password = params[:password]

    renderJson(doRegister(name, email, password))
  end

  def login
    usermail = params[:usermail]
    password = params[:password]

    renderJson(doLogin(usermail, password))
  end

  ##################################################################

  protected

  def doRegister(name, email, password)
    if name.nil? or password.nil? or email.nil?
      return "ERROR_NO_PARAMS"
    else

      if password.length > 16
        return "ERROR_PASSWORD_LONG"
      elsif password.length < 6
        return "ERROR_PASSWORD_SHORT"
      end

      if User.where(username: name).exists?
        return "ERROR_USERNAME_ALREADY_EXISTS"
      elsif User.where(email: email).exists?
        return "ERROR_EMAIL_TAKEN"
      else
        if createUser(email, name, password)
          return "OK"
        else
          return "ERROR"
        end
      end
    end
  end

  # Funcion que prueba si esta logeado y tal
  def doLogin(usermail, password)
    if(usermail.nil?)
      return "ERROR_NO_PARAMS"
    end

    if(usermail.include? "@")
      # Es un correo electronico
      myUser = User.where(email: usermail).first
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
      # Es un nombre de usuario
      myUser = User.where(username: usermail).first
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
