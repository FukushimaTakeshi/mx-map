require 'rails_helper'

RSpec.describe InquiriesController, type: :controller do

  describe 'GET #new' do
    before { get :new }
    it 'httpステータス200が返ること' do
      expect(response).to have_http_status(200)
    end
    it 'newテンプレートを返すこと' do
      expect(response).to render_template(:new)
    end
    it 'インスタンス変数が設定されていること' do
      expect(assigns(:inquiry)).to be_present
    end
  end

  describe 'POST #confirm' do
    let(:inquiry) { FactoryBot.build(:inquiry).instance_values }
    before { post :confirm, params: { inquiry: inquiry } }

    context 'パラメータが正しい場合' do
      it 'httpステータス200が返ること' do
        expect(response).to have_http_status(200)
      end
      it 'confirmテンプレートを返すこと' do
        expect(response).to render_template(:confirm)
      end
      it 'インスタンス変数が設定されていること' do
        expect(assigns(:inquiry)).to be_present
      end
    end

    context 'パラメータが正しくない場合' do
      let(:inquiry) { FactoryBot.build(:inquiry, title: '').instance_values }
      it 'httpステータス200が返ること' do
        expect(response).to have_http_status(200)
      end
      it 'newテンプレートを返すこと' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'POST #create' do
    after { ActionMailer::Base.deliveries.clear }
    let(:inquiry) { FactoryBot.build(:inquiry).instance_values }

    context 'パラメータが正しい場合' do
      before { post :create, params: { inquiry: inquiry } }
      it 'httpステータス200が返ること' do
        expect(response).to have_http_status(200)
      end
      it 'createテンプレートを返すこと' do
        expect(response).to render_template(:create)
      end
      it 'メールが一通送信されていること' do
        expect(ActionMailer::Base.deliveries.size).to eq(1)
      end
      it 'メールの内容が正しいこと' do
        sent_mail = ActionMailer::Base.deliveries.last
        expect(sent_mail.subject).to eq '問い合わせがありました'
        expect(sent_mail.from.first).to eq 'noreply@dirt-awesome.com'
        expect(sent_mail.to.first).to eq Rails.application.credentials.mail[:to]
      end
    end

    context 'パラメータが正しくない場合' do
      subject { post :create, params: { inquiry: inquiry } }
      let(:inquiry) { FactoryBot.build(:inquiry, title: '').instance_values }

      it 'StandardErrorになること' do
        expect { subject }.to raise_error(StandardError)
      end
      it 'メールが一通送信されていないこと' do
        expect(ActionMailer::Base.deliveries.size).to eq(0)
      end
    end
  end
end
