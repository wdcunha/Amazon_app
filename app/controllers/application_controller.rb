class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def user_signed_in?
    # The following is to prevent the app from crashing if we have
    # a `user_id` in the session for a user that no longuer exists
    # our database. Maybe the user was delete or maybe our database
    # was reseeded.
    if session[:user_id].present? && current_user.nil?
      session[:user_id] = nil
    end
    session[:user_id].present?
  end
  helper_method :user_signed_in?

  def current_user
    @current_user ||=User.find_by(id: session[:user_id])
  end
  helper_method :current_user
  # `helper_method` makes a controller method available to all our views

  private
  def authenticate_user!
    unless user_signed_in?
      redirect_to new_session_path, alert: 'You must sign in or sign up first!'
    end
  end

end
