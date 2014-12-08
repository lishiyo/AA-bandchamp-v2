module ApplicationHelper

	def flash_errors
		return unless flash[:errors]

		html = "<div style='margin-top: 20px;'><ul>"
		if flash[:errors].is_a?(String)
			html += flash[:errors]
		else
			flash[:errors].each do |error|
				html += "<div class='alert alert-danger'>#{h(error)}</div>"
			end
			html += "</ul></div>"
		end

		html.html_safe
	end

end
