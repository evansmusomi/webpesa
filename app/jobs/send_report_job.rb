class SendReportJob < ActiveJob::Base
  queue_as :transaction_reports

  # Performs queued 'send report' task.
  # Input(s): Registered user.
  def perform(user)
  	# Send report
    @user = user
    TransactionMailer.activity_report(@user).deliver_now
  end
end
