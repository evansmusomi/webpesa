class TransactionMailer < ApplicationMailer
	# Sends registered user an email notification when they receive money.
	# Input(s): Transaction
	def received_money_email(transaction)
		@transaction = transaction
		email_with_name = "#{@transaction.recipient.name} <#{@transaction.recipient.email}>"
		mail(to: email_with_name, subject: "You're KES #{@transaction.amount} richer on WPESA")
	end

	# Emails an digest (update) of recent transactions to a registered user.
	def activity_report(user)
		@user = user
		email_with_name = "#{user.name} <#{@user.email}>"
		mail(to: email_with_name, subject: "Here's your latest WPESA Activity")
	end
end
