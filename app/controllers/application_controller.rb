class ApplicationController < ActionController::API
  require 'json'

  def renderJson(theJson)
    respond_to do |format|
      format.html { render json: theJson}
      format.json { render json: theJson}
    end
  end
end
