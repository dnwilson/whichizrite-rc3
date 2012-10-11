class PagesController < ApplicationController

	def index
		if signed_in?(:user)
		  	@story = current_user.stories.build		  	
	    end	
	    @stories = Story.all
	end

end