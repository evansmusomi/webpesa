class ApplicationMailer < ActionMailer::Base
  default from: "WPESA <notifications@webpesa.com>"
  helper ApplicationHelper
  layout 'mailer'
end
