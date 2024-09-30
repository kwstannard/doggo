class SessionsController < ApplicationController
  def new
  end

  def create
    session[:role_name]=params[:role]
    dashboard
  end

  def destroy
    session.clear
    redirect_to new_sessions_path
  end
end
