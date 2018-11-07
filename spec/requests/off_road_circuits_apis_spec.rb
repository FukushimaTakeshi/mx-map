require 'rails_helper'

RSpec.describe 'OffRoadCircuitsApis', type: :request do
  describe 'GET /off_road_circuits_apis' do
    before do
      @user = FactoryBot.build(:user)
      @user.skip_confirmation!
      @user.save!
      sign_in @user
    end

    it 'loads a off_road_circuit' do
      off_road_circuit = FactoryBot.create(:off_road_circuit, prefecture_id: 1, region_id: 1)
      get api_off_road_circuits_path, params: {
        user_id: @user.id,
        prefecture_id: off_road_circuit.prefecture_id
      }
      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)
      expect(json.length).to eq 1

      off_road_circuits = json['off_road_circuits']
      expect(off_road_circuits.length).to eq 1
      expect(off_road_circuits[0]['name']).to eq 'テストサーキット'
      expect(off_road_circuits[0]['photo_url']).to eq nil
    end
  end
end
