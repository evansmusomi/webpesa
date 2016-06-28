# Preview all emails at http://localhost:3000/rails/mailers/transaction_mailer
class TransactionMailerPreview < ActionMailer::Preview
	def received_money_email
		TransactionMailer.received_money_email(Transaction.last)
	end
end
