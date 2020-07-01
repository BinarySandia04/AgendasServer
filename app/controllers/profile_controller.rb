class ProfileController < ApplicationController
  def edit_view
    if session[:user_id].nil?
      if isApi
        renderJson("UNAUTHORIZED")
      else
        redirect_to root_url
      end
    end
  end

  def edit
    if session[:user_id].nil?
      if isApi
        renderJson("UNAUTHORIZED")
      else
        redirect_to root_url
      end
    else
      user = current_user
      if user.authenticate(params[:password])
        user.update(displayname: params[:displayname]) unless params[:displayname] == ""
        user.avatar.attach(params[:avatar]) if params[:avatar]

        # user.update_attribute(:avatar, params[:avatar])
        if isApi
          renderJson("OK")
        else
          redirect_to '/profile/' + user.username
        end
      else
        renderResponse("ERROR_AUTHENTICATION", "Password confirmation failed", "edit_view")
      end
    end
  end

  def view
  end

  def view_view
    @user = User.where(username: params[:profile]).first
    if @user
      @is_my_profile = @user.id == session[:user_id]
      @hide_profile_link = @is_my_profile
    end
  end
end
