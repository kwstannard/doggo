class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def dashboard
    case session[:role_name]
    when "Manager"
      redirect_to dogs_path
    when "Walker"
      redirect_to trips_path
    else
      raise "no role"
    end
  end
end
