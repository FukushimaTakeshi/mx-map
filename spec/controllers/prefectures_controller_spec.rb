require 'rails_helper'

RSpec.describe PrefecturesController, type: :controller do

  describe 'GET #index' do
    before do
      off_road_circuit
      allow(Rails).to receive_message_chain(:cache, :fetch).and_return(
        { 'result': { 'rating': 'hoge', 'vicinity': 'hoge' } }.with_indifferent_access
      )
    end

    let(:off_road_circuit) { FactoryBot.create(:off_road_circuit, prefecture_id: 1, region_id: 1) }

    context 'ログインしていない場合' do
      before { get :show, params: { id: 1 } }
      it 'httpステータス200が返ること' do
        expect(response).to have_http_status(200)
      end
      it 'indexテンプレートを返すこと' do
        expect(response).to render_template(:show)
      end
      it 'インスタンス変数が設定されていること' do
        expect(assigns(:prefecture)).to be_present
        expect(assigns(:off_road_circuits)).to be_present
        expect(assigns(:details)).to be_present
        expect(assigns(:favorite_courses)).not_to be_present
      end
    end

    context 'ログインしている場合' do
      before do
        user = FactoryBot.build(:user)
        user.skip_confirmation!
        user.save!
        sign_in user
        FactoryBot.create(:favorite_course, user_id: user.id, off_road_circuit_id: off_road_circuit.id)
        get :show, params: { id: 1 }
      end
      it 'インスタンス変数が設定されていること' do
        expect(assigns(:favorite_courses)).to be_present
      end
    end
  end
end
