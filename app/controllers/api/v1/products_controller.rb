class Api::V1::ProductsController < ApplicationController
before_action :find_product, only: [:show, :destroy]

  def show
    # Test to see if current_user works
    # return render json: current_user
    render json: @product
  end

  def index
    @products = Product.order(created_at: :desc)
  end


private
def find_product
  @product = Product.find params[:id]
end
end
