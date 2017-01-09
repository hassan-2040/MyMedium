class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
      stories_path
  end


  protected
    def configure_permitted_parameters
       devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
       devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to :back, notice: "This isnt your story so lay your hands off of it."
  end
end
