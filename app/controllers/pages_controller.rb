class PagesController < ApplicationController

	def home
		if signed_in?(:user)
		  	@story = current_user.stories.build
		  	@feed_items = current_user.feed.paginate(page: params[:page]) 
	    end	
	end

	def about
		
	end

end