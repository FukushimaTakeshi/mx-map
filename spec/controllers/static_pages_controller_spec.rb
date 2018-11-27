require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe 'GET #terms' do
    before { get :terms }
    it 'httpステータス200が返ること' do
      expect(response).to have_http_status(200)
    end
    it 'termsテンプレートを返すこと' do
      expect(response).to render_template(:terms)
    end
  end

  describe 'GET #privacy' do
    before { get :privacy }
    it 'httpステータス200が返ること' do
      expect(response).to have_http_status(200)
    end
    it 'privacyテンプレートを返すこと' do
      expect(response).to render_template(:privacy)
    end
  end
end
