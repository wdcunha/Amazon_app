class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  # To generate this controller, use the command:
  # `rails g controller Admin::Dashboard --no-assets --no-helper`

  # Because we prefixed the name of the controller with `Admin::`, rails
  # created a subdirectory `admin` where it placed our controller
  # under the name `dashboard_controller.rb`.

  def index
    @users = User.order(created_at: :DESC)
  end

  def panel
    @prodCount = Product.count
    @revCount = Review.count
    @usersCount = User.count
  end


  private
  def authorize_admin!
    redirect_to home_path, alert: 'Access denied!' unless current_user.is_admin?
  end
end
