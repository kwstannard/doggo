class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_role

  def set_role
    @role = session[:role_name]
  end

  def dashboard
    case session[:role_name]
    when "Manager"
      redirect_to dogs_path
    when "Walker"
      redirect_to trips_path
    else
      flash[:error] = "Missing Role"
      redirect_to new_session_path
    end
  end
end
