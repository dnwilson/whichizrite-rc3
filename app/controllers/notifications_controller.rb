class NotificationsController < ApplicationController

	before_filter :authenticate_user!
	# before_filter :correct_user, only: :destroy


	def index
        @notifications = current_user.alerts.paginate(page: params[:page])
    end


	# private
		
		
	# 	def correct_user
	# 		@comment = current_user.comments.find_by_id(params[:id])
 # 	      	redirect_to root_path if @comment.nil?
	# 	end

end