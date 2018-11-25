require 'rails_helper'

RSpec.describe RegionsController, type: :controller do

  describe 'GET #index' do
    before do
      FactoryBot.create(:off_road_circuit, prefecture_id: 1, region_id: 1)
      get :index
    end

    it 'httpステータス200が返ること' do
      expect(response).to have_http_status(200)
    end
    it 'indexテンプレートを返すこと' do
      expect(response).to render_template(:index)
    end
    it 'インスタンス変数が設定されていること' do
      expect(assigns(:regions)).to be_present
      expect(assigns(:prefectures_count)).to be_present
    end
  end

end
