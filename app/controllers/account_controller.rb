class AccountController < ApplicationController
  include ActionController::MimeResponds


  def register()
    username = params[:username]
    password = params[:passwd]

    if username.nil?
      respond_to do |format|
        format.js { render "error" => @object }
        format.html
      end
    end
  end
end

