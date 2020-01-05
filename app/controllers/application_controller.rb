class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :get_current_user, :is_logged_in?

  def get_current_user
    id = session[:user_id]
    @current_user ||= User.find(session[:user_id]) if id
  end

  def is_logged_in?
    !!get_current_user
  end

  def require_user
    if !is_logged_in?
      notice = "You must be logged in to perform this action."
      redirect_to root_path
    end
  end
end
