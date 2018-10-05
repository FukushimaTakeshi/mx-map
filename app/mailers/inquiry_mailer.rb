class InquiryMailer < ApplicationMailer
  def received_email(inquiry)
    mail_subject = '問い合わせがありました'

    @inquiry = inquiry
    mail(subject: mail_subject)
  end
end
