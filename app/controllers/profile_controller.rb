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
      if @user.authenticate(params[:password])

        # Update fields
        if params[:avatar]
          @user.avatar.attach(params[:avatar])

          # Muy feo quiero crear un callback en user.rb
          @user.avatar_formatting
        end

        @user.displayname = params[:displayname] unless params[:displayname] == ""
        @user.name = params[:name] unless params[:name] == ""
        @user.surname = params[:surname] unless params[:surname] == ""
        @user.birthdate = params[:birthdate][0]
        @user.update_attribute(:description, params[:description])


        if isApi
          renderJson("OK")
        else
          redirect_to '/profile/' + @user.username
        end
      else
        renderResponse("ERROR_AUTHENTICATION", "Password confirmation failed", "edit_view", "red")
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
    end
  end
end
