module DiysHelper

	def have_diy?
		@diy=Diy.where(:user_id => current_user.id)
		return true if @diy.count>0
		return false
	end

end
