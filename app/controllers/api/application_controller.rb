class Api::ApplicationController < ApplicationController
  skip_before_action :verify_authenticity_token


  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def current_user
    # @user ||= User.find_by(api_key: api_key) if api_key.present?
    token_type, token = request.headers["AUTHORIZATION"]&.split(" ") || []
    # @user ||= User.find_by(api_key: api_key) if api_key.present?
    case token_type&.downcase
    when 'api_key'
      @user ||= User.find_by(api_key: token)
    when 'jwt'
      # `begin .. rescue` allows to prevent the code
      # between `begin` and `rescue` from crashing your application.
      # If anything inside crashes, the code between `rescue .. end`
      # will excute and get access to an error object
      # http://blog.honeybadger.io/a-beginner-s-guide-to-exceptions-in-ruby/
      begin
        payload = JWT.decode(
          token,
          Rails.application.secrets.secret_key_base
        )&.first
        # The payload return from JWT.decode is hash where
        # keys are strings. You can not use symbols to access its values.
        @user ||= User.find(payload["id"])
      rescue JWT::DecodeError => error
        nil
      end
    end

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
