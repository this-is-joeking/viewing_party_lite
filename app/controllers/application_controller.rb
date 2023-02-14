# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user # this gives access to the method in the views!! mind blown
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]

    # ||= is memoization, after the first time you call the method it will check if it has been defined within
    # the request. It caches the value for the duration of the request so we don't have to find the user 10x
    # to load the page a single time.
  end

  def validate_user
    return if current_user

    flash[:error] = 'You must be logged in to access this page'
    redirect_back(fallback_location: root_path)
  end
end
