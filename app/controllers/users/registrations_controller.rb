class Users::RegistrationsController < Devise::RegistrationsController
	prepend_before_filter :authenticate_scope!, :only => [:edit, :update, :destroy, :password]

    def settings_password
    end

	def update
	    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
	 
	    # If the user has filled in any of the password fields, we'll update their password
	    any_passwords = %w(password password_confirmation current_password).any? do |field|
	      params[resource_name][field].present?
	    end
	    update_method = any_passwords ? :update_with_password : :update_without_password
	 
	    if resource.send(update_method, params[resource_name])
	      set_flash_message :notice, :updated if is_navigational_format?
	      sign_in resource_name, resource, :bypass => true
	      respond_with resource, :location => after_update_path_for(resource)
	    else
	      clean_up_passwords(resource)
	      respond_with_navigational(resource){ render :edit }
	    end
  	end
  
  	protected
      def after_update_path_for(resource)
        user_path(resource)
      end

end