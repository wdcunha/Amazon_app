class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :show, :index]
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  # before_action :find_product, only: [:show, :destroy]
  before_action :authorize_user!, only: [:edit] #, :update, :destroy]

  def index
    @favourited = params[:favourited]
    if @favourited
      @products = current_user.favourited_products
    else
      @products = Product.all.order(created_at: :desc)
    end
  end
  #
  def new
    @product = Product.new
  end
  #
  def create
    @product = Product.new product_params
    # @product.user_id = current_user
    @product.user = current_user

    if @product.save
      redirect_to product_path(@product)
      # redirect_to @product
    else
      render :new
    end
  end
  #
  def show
    @reviews = @product.reviews.order(created_at: :desc)
    @review = Review.new
    @user_favourite = current_user.favourites.find_by_product_id(@product) if user_signed_in?
    # @user_vote = current_user.votes.find_by_review_id(@review) if user_signed_in?
  end

  def edit
  end

  def update
    @product.slug = nil # this will force friendly_id to re-generate slug, if
                     # we enabled the `history` option then the previous
                     # will be stored history and will still work
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit
    end
  end
  #
  #
  def destroy
    @product.destroy
    redirect_to products_path, alert: 'Product deleted'
  end


  private
  def product_params
    params.require(:product).permit(:title, :description, :price, :image, { tag_ids: [] })
  end

  def find_product
    @product = Product.find params[:id]
  end


  def authorize_user!
    # When using cancancan methods like `can?`, it knows
    # the logged in user as long as the method `current_user`
    # is defined for controllers.
    # binding.pry
    unless can?(:manage, @product)
      flash[:alert] = "Access Denied!"
      redirect_to home_path
    end
  end
end





# bump
