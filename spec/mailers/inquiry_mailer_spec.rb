require 'rails_helper'

RSpec.describe InquiryMailer, type: :mailer do
  after { ActionMailer::Base.deliveries.clear }

  describe '#received_email' do

    describe 'メール送信前' do
      it 'メール送信0件であること' do
        expect(ActionMailer::Base.deliveries.size).to eq(0)
      end

      describe 'メール送信後' do
        before { mail.deliver }
        let(:inquiry) { FactoryBot.build(:inquiry) }
        let(:mail) { InquiryMailer.received_email(inquiry) }

        it 'メールが一通送信されていること' do
          expect(ActionMailer::Base.deliveries.size).to eq(1)
        end
        it 'メールのheaderが想定通り' do
          send_mail = ActionMailer::Base.deliveries.last
          expect(send_mail.subject).to eq '問い合わせがありました'
          expect(send_mail.from.first).to eq 'noreply@dirt-awesome.com'
          expect(send_mail.to.first).to eq Rails.application.credentials.mail[:to]
        end
        it 'メールのbodyが想定通り' do
          send_mail = ActionMailer::Base.deliveries.last
          expect(send_mail.body.raw_source).to match(/\A<!DOCTYPE html><html>.*メールアドレス.*#{inquiry.email}.*タイトル.*#{inquiry.title}.*問い合わせ内容.*#{inquiry.message}.*<\/html>\z/)
        end
      end
    end
  end
end
