module UsersHelper

	def show_photo
       url=""
       image_tag(url, alt: user.name, class: "gravatar")
	end


end
