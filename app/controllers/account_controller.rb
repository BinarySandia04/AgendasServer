class AccountController < ApplicationController
  include ActionController::MimeResponds

  def logintest
    loginInfo = getLoginInfo

    name = loginInfo["name"]
    email = loginInfo["email"]
    pass = loginInfo["pass"]

    renderJson(login(name, email, pass))
  end

  def register
    loginInfo = getLoginInfo

    name = loginInfo["name"]
    email = loginInfo["email"]
    password = loginInfo["pass"]

    if name.nil? or password.nil? or email.nil?
      renderJson('ERROR_NO_PARAMS')
    else

      if password.length > 16
        renderJson("ERROR_PASSWORD_LONG")
        return
      elsif password.length < 6
        renderJson("ERROR_PASSWORD_SHORT")
        return
      end

      if User.where(username: name).exists?
        renderJson("ERROR_USERNAME_ALREADY_EXISTS")
      elsif User.where(email: email).exists?
        renderJson("ERROR_EMAIL_ALREADY_EXISTS")
      else
        if createUser(email, name, password)
          renderJson("OK")
        else
          renderJson("ERROR")
        end
      end
    end
  end

  protected
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

