class ApplicationController < ActionController::Base
  before_filter :ensure_signup_complete, only: [:new, :create, :update, :destroy]
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_action :configure_permitted_parameters, if: :devise_controller?
  def ensure_sign_up_complete

    return if #action_name == 'finish_signup'

    if current_user && !current_user.email_verified?
      redirect_to
  #private

  #def configure_permitted_parameters
   # devise_parameter_sanitizer.for(:sign_up) << :
end
