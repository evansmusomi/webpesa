class TransactionMailer < ApplicationMailer
	def received_money_email(transaction)
		@transaction = transaction
		mail(to: @transaction.recipient.email, subject: "#{@transaction.sender.name} sent you money on WPESA")
	end
end
