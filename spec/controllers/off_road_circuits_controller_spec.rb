require 'rails_helper'

RSpec.describe OffRoadCircuitsController, type: :controller do

  before do
    user = FactoryBot.build(:user, admin: admin)
    user.skip_confirmation!
    user.save!
    sign_in user
  end

  let(:off_road_circuit) { FactoryBot.create(:off_road_circuit, prefecture_id: 1, region_id: 1) }

  describe 'GET #show' do
    let(:admin) { false }
    before do
      allow(Rails).to receive_message_chain(:cache, :fetch).and_return(
        { 'result': { 'rating': 'hoge', 'vicinity': 'hoge' } }.with_indifferent_access
      )
    end

    context 'リクエストされたデータが存在する場合' do
      before { get :show, params: { id: off_road_circuit.id } }
      it 'httpステータス200が返ること' do
        expect(response).to have_http_status(200)
      end
      it 'showテンプレートを返すこと' do
        expect(response).to render_template(:show)
      end
      it 'インスタンス変数が設定されていること' do
        expect(assigns(:off_road_circuit)).to be_present
        expect(assigns(:detail)).to be_present
      end
    end
    context 'リクエストされたデータが存在しない場合' do
      subject { get :show, params: { id: off_road_circuit.id + 1 } }
      it '404が返ること' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'GET #new' do
    before do
      place_search_mock = double('place_search_mock')
      allow(PlaceSearch).to receive(:new).and_return(place_search_mock)
      allow(PlaceSearch.new).to receive(:details).and_return(
        { 'result': {
          'address_components': [
            { 'long_name': '北海道',
              'types': ['administrative_area_level_1']
            }
          ],
          'name': 'name',
          'vicinity': 'vicinity'
        } }.with_indifferent_access
      )
      get :new, params: { place_id: 'hoge' }
    end

    context 'adminユーザの場合' do
      let(:admin) { true }
      it 'httpステータス200が返ること' do
        expect(response).to have_http_status(200)
      end
      it 'newテンプレートを返すこと' do
        expect(response).to render_template(:new)
      end
      it 'インスタンス変数が設定されていること' do
        expect(assigns(:place_search)).to be_present
        expect(assigns(:off_road_circuit)).to be_present
      end
    end

    context 'adminユーザ以外の場合' do
      let(:admin) { false }
      it 'httpステータス302が返ること' do
        expect(response).to have_http_status(302)
      end
      it 'リダイレクトされること' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST #create' do
    subject { post :create, params: params }

    let(:admin) { true }
    let(:params) do
      { off_road_circuit:
        { name: name,
          address: '北海道釧路市',
          url: 'http://example.com',
          place_id: place_id,
          prefecture_id: prefecture_id,
          region_id: region_id
        }
      }
    end
    context 'パラメータが正しい場合' do
      let(:name) { 'name' }
      let(:place_id) { '12345' }
      let(:prefecture_id) { 1 }
      let(:region_id) { 1 }

      it 'httpステータス302が返ること' do
        is_expected.to have_http_status(302)
      end
      it 'リダイレクトされること' do
        is_expected.to redirect_to root_path
      end
      it 'OffRoadCircuitレコードが1増えること' do
        expect{ subject }.to change(OffRoadCircuit, :count).by(1)
      end
    end

    context 'パラメータが正しくない場合' do
      let(:name) { '' }
      let(:place_id) { '12345' }
      let(:prefecture_id) { 1 }
      let(:region_id) { 1 }

      it 'httpステータス200が返ること' do
        is_expected.to have_http_status(200)
      end
      it 'newテンプレートを返すこと' do
        is_expected.to render_template(:new)
      end
      it 'OffRoadCircuitレコードが1増えないこと' do
        expect{ subject }.not_to change(OffRoadCircuit, :count)
      end
    end
  end



  describe 'GET #edit' do
    let(:admin) { true }
    context 'リクエストされたデータが存在する場合' do
      before { get :edit, params: { id: off_road_circuit.id } }
      it 'httpステータス200が返ること' do
        expect(response).to have_http_status(200)
      end
      it 'showテンプレートを返すこと' do
        expect(response).to render_template(:edit)
      end
      it 'インスタンス変数が設定されていること' do
        expect(assigns(:off_road_circuit)).to be_present
      end
    end
    context 'リクエストされたデータが存在しない場合' do
      subject { get :edit, params: { id: off_road_circuit.id + 1 } }
      it '404が返ること' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'PATCH #update' do
    let(:admin) { true }
    let(:params) do
      { off_road_circuit:
        { name: name,
          address: '北海道釧路市',
          url: 'http://example.com',
          place_id: 12345,
          prefecture_id: 1,
          region_id: 1
        }
      }
    end
    let(:name) { 'hoge' }

    context 'リクエストされたデータが存在する場合' do
      subject { patch :update, params: { id: off_road_circuit.id }.merge(params) }

      context 'パラメータが正しい場合' do
        it 'httpステータス302が返ること' do
          is_expected.to have_http_status(302)
        end
        it 'リダイレクトされること' do
          is_expected.to redirect_to(off_road_circuit_path(off_road_circuit))
        end
        it 'レコードの値が更新されること' do
          subject
          off_road_circuit.reload
          expect(off_road_circuit.name).to eq 'hoge'
        end
      end

      context 'パラメータが正しくない場合' do
        let(:name) { '' }

        it 'httpステータス200が返ること' do
          is_expected.to have_http_status(200)
        end
        it 'editテンプレートを返すこと' do
          is_expected.to render_template(:edit)
        end
        it 'レコードの値が更新されないこと' do
          subject
          off_road_circuit.reload
          expect(off_road_circuit.name).to eq 'テストサーキット'
        end
      end
    end

    context 'リクエストされたデータが存在しない場合' do
      subject { patch :update, params: { id: off_road_circuit.id + 1 }.merge(params) }
      it '404が返ること' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
