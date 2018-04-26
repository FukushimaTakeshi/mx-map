require 'rails_helper'

RSpec.describe PrefecturesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    before { FactoryBot.create(:prefecture) }
    it "returns http success" do
      get :show, params: { id: 1 }
      expect(response).to have_http_status(200)
    end
  end

end
