class ContactusController < ApplicationController
  def new
  end

  def thankyou
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
  end

end
