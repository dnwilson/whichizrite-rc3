class PagesController < ApplicationController

	def index
		if signed_in?(:user)
		  	@story = current_user.stories.build	
		  	@feed_items = current_user.feed.paginate(page: params[:page])	  	
	    end	
	    @stories = Story.all
	end

end