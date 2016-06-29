module ApplicationHelper
	# Converts date provided to more user friendly format.
	def human_date(date)
		date.strftime("%B %-d, %Y")
	end

	# Converts time provided to more user friendly format.
	def human_time(date)
		date.strftime("on %d/%m/%y at %k:%I %p")
	end

	# Escapes HTML elements in the object provided.
	def innocent(html)
		html.html_safe
	end

	# Sets active navigation link depending on the current page.
	def nav_link(link_text, link_path)
		class_name = current_page?(link_path) ? 'active' : ''

		content_tag(:li, class: class_name) do
			link_to link_text, link_path
		end
	end
end
