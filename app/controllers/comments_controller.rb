class CommentsController < ApplicationController

	before_filter :authenticate_user!

	# before_filter :correct_user, only: :destroy

	def create
		@comment = current_user.comments.create(params[:comment])
		redirect_to :back
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		redirect_to @comment.story
	end

	# private
	# 	def correct_user
	# 		@comment = current_user.comments.find_by_id(params[:id])
 	#       redirect_to root_path if @comment.nil?
	# 	end
end