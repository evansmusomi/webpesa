class SendEmailJob < ActiveJob::Base
  queue_as :transaction_emails

  def perform(transaction)
  	# Send email
    @transaction = transaction
    TransactionMailer.received_money_email(@transaction).deliver_now
  end
end
