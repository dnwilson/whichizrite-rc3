module SessionsHelper
	def current_user?(user)
		user == current_user
	end

	def notifications?(user)
		@notifications = current_user.alerts.paginate(page: params[:page])
	end

	def resource_name
    	:user
  	end

	def resource
		@resource ||= User.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end
end