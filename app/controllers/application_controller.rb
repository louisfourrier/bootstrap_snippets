class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  helper_method :is_administrator 
  
  def is_administrator?
    if current_user.nil?
      redirect_to new_user_session_path, notice: 'You must be log in to perform this action'
    elsif !current_user.is_administrator
      redirect_to root_url, notice: "You are not authorized to perform this action"
    end
  end
  
  def is_administrator
    if current_user && current_user.is_administrator
      return true
    else
      return false
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :pseudo) }
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:pseudo, :email, :password, :password_confirmation, :current_password)
    end
  end

end
