module BandsHelper
	
	def taggify(genres)
		
		html = "<span class='.text-genre-tags'>"
		html += genres.reduce([]) do |memo, genre|
			memo << "<a href='/genres/#{genre.id}' > #{genre.category}</a>"	
			memo
		end.join(" | ")
		
		html += "</span>"
		
		html.html_safe
	end
	
end
