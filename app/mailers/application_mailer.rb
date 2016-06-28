class ApplicationMailer < ActionMailer::Base
  default from: "notifications@webpesa.com"
  helper ApplicationHelper
  layout 'mailer'
end
