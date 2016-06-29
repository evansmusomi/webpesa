class SendEmailJob < ActiveJob::Base
  queue_as :transaction_emails

  # Performs queued 'send email' task when transaction is successful.
  # Input(s): Transaction.
  def perform(transaction)
  	# Send email
    @transaction = transaction
    TransactionMailer.received_money_email(@transaction).deliver_now
  end
end
