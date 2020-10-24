class ProfileController < ApplicationController
  def edit_view
    @user = current_user
    if session[:user_id].nil?
      if isApi
        renderJson("UNAUTHORIZED")
      else
        redirect_to root_url
      end
    end
  end

  def edit
    @user = current_user
    if session[:user_id].nil?
      if isApi
        renderJson("UNAUTHORIZED")
      else
        redirect_to root_url
      end
    else
      if User.where(displayname: params[:displayname]).size > 1
        renderResponse("ERROR_SAME_USERNAME", "Ja existeix un usuari amb aquest nom d'usuari!", "edit_view", "red")
        return
      end

      if @user.authenticate(params[:password])

        # Update fields
        if params[:avatar]
          @user.avatar.attach(params[:avatar])

          # Muy feo quiero crear un callback en user.rb
          avatarResult = @user.avatar_formatting
          if avatarResult != 'OK'
            if avatarResult == 'SIZE_ERROR'
              renderResponse("SIZE_ERROR", "L'avatar d'usuari no pot ser més gran que 3MB", "edit_view", "red")
            else
              renderResponse("FILE_ERROR", "Format d'arxiu no compatible", "edit_view", "red")
            end
          end
        end

        @user.displayname = params[:displayname] unless params[:displayname] == ""
        @user.name = params[:name] unless params[:name] == ""
        @user.surname = params[:surname] unless params[:surname] == ""
        @user.birthdate = params[:birthdate][0]
        @user.update_attribute(:description, params[:description])


        if isApi
          renderJson("OK")
        else
          redirect_to '/profile/' + @user.id.to_s
          return
        end
      else
        renderResponse("ERROR_AUTHENTICATION", "La contrasenya que has introduït es incorrecta", "edit_view", "red")
        return
      end
    end
  end

  def view
    @user = current_user
  end

  def view_view
    @user = current_user

    @viewuser = User.find_by_id(params[:user])
    if @viewuser
      @is_my_profile = @viewuser.id == @user.id
      @hide_profile_link = @is_my_profile
      if isApi
        properties = {"username" => @viewuser.username, "desc" => @viewuser.description}
        if @viewuser.avatar.attached?
          properties["pic"] = url_for(@viewuser.avatar)
        end
        renderJson(properties)
      end
    end
  end
end
