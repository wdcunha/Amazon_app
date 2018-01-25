class UsersController < ApplicationController

  def index
    if user_signed_in? && current_user.longitude
      users = User.near([current_user.latitude, current_user.longitude], 120)
      # @hash = Gmaps4rails.build_markers(users) do |user, marker|
      @markers = Gmaps4rails.build_markers(users) do |user, marker|
        marker.lat user.latitude
        marker.lng user.longitude
        # marker.infowindow user.full_name
        marker.infowindow "<a href='#{user_path(user)}'>#{user.full_name}</a>"
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      # The `session` object allows to store information that is persisted between
      # between requests. Each browser receives its own independent session.
      # They're implement with cookies in the browser.
      session[:user_id] = @user.id
      # The `flash` is a hash-like global object available to controllers
      # and views. It used to store information that will be available for
      # next request only.
      flash[:notice] = "Thank you for signing up, #{@user.first_name}!"
      redirect_to home_path
    else
      render :new
    end
  end

  def show
    @user = User.find params[:id]
  end

  private
  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :address,
      :password,
      :password_confirmation
    )
  end
end
