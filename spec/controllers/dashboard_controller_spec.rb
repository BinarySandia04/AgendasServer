require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  describe "GET #admin_dashboard" do
    it "returns http success" do
      get :admin_dashboard
      expect(response).to have_http_status(:success)
    end
  end

end
