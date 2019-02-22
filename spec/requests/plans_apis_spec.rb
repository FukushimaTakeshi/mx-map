require 'rails_helper'

RSpec.describe 'PlansApis', type: :request do
  before do
    @user = FactoryBot.build(:user, username: 'hoge_user')
    @user.skip_confirmation!
    @user.save!
    sign_in @user

    off_road_circuit
    FactoryBot.create(:photo, off_road_circuit_id: off_road_circuit.id)
    plan
  end

  let(:off_road_circuit) { FactoryBot.create(:off_road_circuit, prefecture_id: 1, region_id: 1) }
  let(:plan) { FactoryBot.create(:plan, date: Date.today, off_road_circuit_id: off_road_circuit.id, user_id: @user.id) }

  describe 'GET /api/plans/?userid=:user_id&off_road_circuit=:off_road_circuit_id' do
    before { get api_plans_path(user_id: @user.id, off_road_circuit: off_road_circuit.id, date: Date.today) }
    it 'httpステータス200が返ること' do
      expect(response).to have_http_status(200)
    end

    it 'レスポンスが想定通り' do
      json = JSON.parse(response.body)
      expect(json['plans'].length).to eq 1
      expect(json['plans'][0]['id']).to eq plan.id

      expect(json['plans'][0]['user_details']['id']).to eq @user.id
      expect(json['plans'][0]['user_details']['username']).to eq @user.username
      expect(json['plans'][0]['user_details']['avatar']).to eq @user.avatar&.url

      expect(json['plans'][0]['off_road_circuit_id']).to eq off_road_circuit.id
      expect(json['plans'][0]['off_road_circuit_name']).to eq off_road_circuit.name

      expect(json['id']).to eq nil
    end
  end

  describe 'POST /api/plans' do
    context 'パラメータが正しい場合' do
      let(:params) { { plan: { date: Date.today, off_road_circuit_id: off_road_circuit.id, user_id: @user.id } } }
      it 'httpステータス201が返ること' do
        post api_plans_path, params: params
        expect(response).to have_http_status(:created)
      end
      it 'Planレコードが1増えること' do
        expect{ post api_plans_path, params: params }.to change(Plan, :count).by(1)
      end
    end

    context 'パラメータが正しくない場合' do
      let(:params) { { plan: { date: Date.today, off_road_circuit_id: '' , user_id: @user.id } } }
      it 'httpステータス422が返ること' do
        post api_plans_path, params: params
        expect(response).to have_http_status(422)
      end
      it 'Planレコードが1増えないこと' do
        expect{ post api_plans_path, params: params }.not_to change(Plan, :count)
      end
    end
  end

  describe 'DELETE /api/plans/:id' do
    it 'httpステータス200が返ること' do
      delete api_plan_path(plan)
      expect(response).to have_http_status(200)
    end
    it 'FavoriteCourseレコードが1削除されること' do
      expect{ delete api_plan_path(plan) }.to change(Plan, :count).by(-1)
    end
  end
end
