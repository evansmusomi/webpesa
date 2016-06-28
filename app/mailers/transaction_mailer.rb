class TransactionMailer < ApplicationMailer
	def received_money_email(transaction)
		@transaction = transaction
		email_with_name = "#{@transaction.recipient.name} <#{@transaction.recipient.email}>"
		mail(to: email_with_name, subject: "#{@transaction.sender.name} sent you money on WPESA")
	end
end
