require 'rails_helper'

RSpec.describe 'OffRoadCircuitsApis', type: :request do
  describe 'GET /off_road_circuits_apis' do
    before do
      @user = FactoryBot.build(:user)
      @user.skip_confirmation!
      @user.save!
      sign_in @user
      
      off_road_circuit = FactoryBot.create(:off_road_circuit, prefecture_id: 1, region_id: 1)
      FactoryBot.create(:photo, off_road_circuit_id: off_road_circuit.id)
      get api_off_road_circuits_path, params: {
        user_id: @user.id,
        prefecture_id: off_road_circuit.prefecture_id
      }
    end

    it 'httpステータス200が返ること' do
      expect(response).to have_http_status(200)
    end
      
    it 'レスポンスが想定通り' do
      json = JSON.parse(response.body)
      expect(json.length).to eq 1
      expect(json['off_road_circuits'].length).to eq 1
      expect(json['off_road_circuits'][0]['name']).to eq 'テストサーキット'
      expect(json['off_road_circuits'][0]['photo_url']).to eq 'https://sample.com'
    end
  end
end
