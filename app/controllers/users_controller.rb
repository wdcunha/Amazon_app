class UsersController < ApplicationController
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

private
def user_params
  params.require(:user).permit(
    :first_name,
    :last_name,
    :email,
    :password,
    :password_confirmation
  )
end

end
