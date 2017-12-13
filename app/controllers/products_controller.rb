class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all.order(created_at: :desc)
  end

def new
  @product = Product.new
end

def create
  @product = Product.new product_params
  # @product.user_id = current_user
  @product.user = current_user

  if @product.save
    redirect_to product_path(@product)
  else
    render :new
  end
end

  def show
    @reviews = @product.reviews.order(created_at: :desc)
    @review = Review.new

  end

  def edit

  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit
    end
  end


  def destroy
    @product.destroy
    redirect_to products_path
  end
end

private
def product_params
  params.require(:product).permit(:title, :description, :price)
end

def find_product
  @product = Product.find params[:id]
end