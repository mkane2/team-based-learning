class ApplicationMailer < ActionMailer::Base
  default from: Rails.configuration.professor_email
  layout 'mailer'
end
