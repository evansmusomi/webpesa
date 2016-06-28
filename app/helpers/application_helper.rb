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

	# Set active nav based on current page
	def nav_link(link_text, link_path)
		class_name = current_page?(link_path) ? 'active' : ''

		content_tag(:li, class: class_name) do
			link_to link_text, link_path
		end
	end
end
