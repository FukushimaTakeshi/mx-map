require 'rails_helper'

RSpec.describe PlaceSearchController, type: :controller do

  before do
    user = FactoryBot.build(:user, admin: admin)
    user.skip_confirmation!
    user.save!
    sign_in user
  end

  describe 'GET #search' do
    before { get :search }
    context 'adminユーザの場合' do
      let(:admin) { true }
      it 'httpステータス200が返ること' do
        expect(response).to have_http_status(200)
      end
      it 'searchテンプレートを返すこと' do
        expect(response).to render_template(:search)
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

  describe 'GET #index' do
    before do
      place_search_mock = double('place_search_mock')
      allow(PlaceSearch).to receive(:new).and_return(place_search_mock)
      allow(PlaceSearch.new).to receive(:search).and_return('awesome')
      get :index, params: { q: 'hoge' }
    end

    context 'adminユーザの場合' do
      let(:admin) { true }
      it 'httpステータス200が返ること' do
        expect(response).to have_http_status(200)
      end
      it 'indexテンプレートを返すこと' do
        expect(response).to render_template(:index)
      end
      it 'インスタンス変数が設定されていること' do
        expect(assigns(:place_search)).to eq 'awesome'
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

end
