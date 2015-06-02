module ApplicationHelper
	def full_title(page_title = '')
		base_title = "Ruby on Rails Tutorial Sample App"
		if page_title.empty?
			base_title
		else 
			page_title + ' | ' + base_title
		end
	end

	def funky_shuffler(string)
		#split into array of characters
		#shuffle
		#join back together 
		string.split("").shuffle.join
	end
end
