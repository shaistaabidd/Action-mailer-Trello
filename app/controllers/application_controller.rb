class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to boards_path, :alert => exception.message
  end

  protected

    def configure_permitted_parameters
      
      devise_parameter_sanitizer.permit(:sign_up,
        keys: [:username, :email, :password])
      
      devise_parameter_sanitizer.permit(:sign_in,
        keys: [:login, :password])
      
      devise_parameter_sanitizer.permit(:account_update,
        keys: [:username, :name, :email, :password_confirmation, :current_password])
      
      devise_parameter_sanitizer.permit(:accept_invitation, keys: [:username, :password, :password_confirmation])
    
    end
end
