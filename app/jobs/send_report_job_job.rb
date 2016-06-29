class SendReportJobJob < ActiveJob::Base
  queue_as :transaction_reports

  def perform(user)
  	# Send report
    @user = user
    TransactionMailer.activity_report(@user).deliver_now
  end
end
