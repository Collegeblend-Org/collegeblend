class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit 
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  private 
  
    def user_not_authorized
      flash[:alert] = "Access denied."
      redirect_to (request.referrer || root_path)
    end 
    
    def after_sign_in_path_for(resource_or_scope)
      if current_user.admin?
        users_path
      else
        current_user
      end
    end
    
    def after_sign_out_path_for(resource_or_scope)
      '/users/sign_in'
    end
    
    def after_sign_up_path_for(resource)
      after_sign_in_path_for(resource)
    end
    
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:first_name, :middle_initial, :last_name, :email, :birthdate, :password, :remember_me])
    devise_parameter_sanitizer.permit(:sign_in, keys:[:email, :password, :remember_me])
    devise_parameter_sanitizer.permit(:account_update, keys:[:first_name, :middle_initial, :last_name, :email, :birthdate, :password, :remember_me])
  end
end
