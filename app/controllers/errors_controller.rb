class ErrorsController < ApplicationController

  def show
    status_code = params[:code] || 500
    flash.now[:red] = "Error #{status_code}"
  end

end
