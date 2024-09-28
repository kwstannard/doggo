class SessionsController < ApplicationController
  def new
  end

  def create
    session[:role_name]=params[:role]
    dashboard
  end
end
