require 'rails_helper'

RSpec.describe 'RegionsApis', type: :request do
  describe 'GET /regions_apis' do
    before { get api_regions_path }

    it 'httpステータス200を返ること' do
      expect(response).to have_http_status(:success)
    end
    
    it 'レスポンスが想定通り' do
      json = JSON.parse(response.body)
      expect(json.length).to eq 8
      expect(json[1]['id']).to eq 2
      expect(json[1]['name']).to eq '東北'
      expect(json[1]['prefectures'][0]['id']).to eq 2
      expect(json[1]['prefectures'][0]['name']).to eq '青森県'
    end
  end
end
