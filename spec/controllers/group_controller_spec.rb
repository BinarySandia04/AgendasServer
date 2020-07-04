require 'rails_helper'

RSpec.describe GroupController, type: :controller do

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #join" do
    it "returns http success" do
      get :join
      expect(response).to have_http_status(:success)
    end
  end

end
