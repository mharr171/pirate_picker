class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@pirate-picker.herokuapp.com'
  layout 'mailer'
end
