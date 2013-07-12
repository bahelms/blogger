module ApplicationHelper
	def full_title(title)
		if title.empty?
			"Blogger"
		else
			"Blogger | #{title}"
		end
	end
end
