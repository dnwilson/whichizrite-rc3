class CommentsController < ApplicationController

	before_filter :authenticate_user!

	def create
		@comment = current_user.comments.build(param[:comment])
		redirect_to :back
	end
end