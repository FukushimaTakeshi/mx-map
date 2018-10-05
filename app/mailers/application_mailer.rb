class ApplicationMailer < ActionMailer::Base
  default from: "noreply@#{Rails.application.credentials.domain}"
  default to: Rails.application.credentials.mail[:to]
  layout 'mailer'
end
