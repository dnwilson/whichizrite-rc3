class RegistrationsController < Devise::RegistrationsController
	prepend_before_filter :authenticate_scope!, :only => [:edit, :update, :destroy, :password]

    def settings_password
      if resource.update_with_password(params[resource_name])
        set_flash_message :notice, :updated if is_navigational_format?
        sign_in resource_name, resource, :bypass => true
        respond_with resource, :location => after_update_path_for(resource)
      else
        clean_up_passwords(resource)
        respond_with_navigational(resource) do
          if params[:change_password] # or flash[:change_password]
            render_with_scope :change_password
          else
            render_with_scope :edit
          end
        end
      end
    end

	def update
	    @user = User.find(current_user.id)
	    email_changed = @user.email != params[:user][:email]
	    
	    successfully_updated = if email_changed
	      @user.update_with_password(params[:user])
	    else
	      @user.update_without_password(params[:user])
	    end

	    if successfully_updated
	      # Sign in the user bypassing validation in case his password changed
	      sign_in @user, :bypass => true
	      redirect_to root_path
	    else
	      render "edit"
	    end
	end

end