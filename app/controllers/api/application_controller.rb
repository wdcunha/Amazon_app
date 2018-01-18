class Api::ApplicationController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def current_user
    @user ||= User.find_by(api_key: api_key) if api_key.present?
  end
  helper_method :current_user

  def authenticate_user!
    head :unauthorized unless current_user.present?
  end
  
  private
  def api_key
    request.headers['AUTHORIZATION']
  end

end
