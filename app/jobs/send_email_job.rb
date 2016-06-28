class SendEmailJob < ActiveJob::Base
  queue_as :default

  def perform(transaction)
  	# Send email
    @transaction = transaction
    TransactionMailer.received_money_email(@transaction).deliver_later
  end
end
