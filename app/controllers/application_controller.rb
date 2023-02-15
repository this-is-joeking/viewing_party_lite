# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def validate_user
    return if current_user

    flash[:error] = 'You must be logged in to access this page'
    redirect_back(fallback_location: root_path)
  end
end
