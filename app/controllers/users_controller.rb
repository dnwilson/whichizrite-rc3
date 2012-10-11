class UsersController < ApplicationController
	before_filter :authenticate_user!, only: [:index, :edit, :update, :destroy]
	before_filter :correct_user, only: [:edit, :update]
	before_filter :admin_user, only: :destroy

	def show
		@user = User.find(params[:id])
		@stories = @user.stories.paginate(page: params[:page])
	end

	def index
		@users = User.paginate(page: params[:page])
	end

	private

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end

end