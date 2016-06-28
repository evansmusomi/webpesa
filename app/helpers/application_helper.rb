module ApplicationHelper
	# Make date to more user friendly format
	def human_date(date)
		date.strftime("%B %-d, %Y")
	end

	# Make time more user friendly format
	def human_time(date)
		date.strftime("on %d/%m/%y at %k:%I %p")
	end

	# Escape HTML
	def innocent(html)
		html.html_safe
	end
end
