class CommentsController < ApplicationController

	before_filter :authenticate_user!
	before_filter :correct_user, only: :destroy

	def create
		# @comments = Comment.all
		@comment = current_user.comments.create(params[:comment])
		@story = @comment.story
		respond_to do |format|
            format.html {redirect_to @comment.story}
            format.js
        end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		redirect_to @comment.story
	end



	private
		def correct_user
			@comment = current_user.comments.find_by_id(params[:id])
 	      redirect_to root_path if @comment.nil?
		end
end