class TransactionMailer < ApplicationMailer
	# Send money recipient an email notification
	def received_money_email(transaction)
		@transaction = transaction
		email_with_name = "#{@transaction.recipient.name} <#{@transaction.recipient.email}>"
		mail(to: email_with_name, subject: "You're KES #{@transaction.amount} richer on WPESA")
	end

	# Email an update to users who had transactions recently
	def activity_report(user)
		@user = user
		email_with_name = "#{user.name} <#{@user.email}>"
		mail(to: email_with_name, subject: "Here's your latest WPESA Activity")
	end
end
