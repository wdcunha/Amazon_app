class ReviewsController < ApplicationController
  before_action :authenticate_user!, :find_product
  before_action :find_review, :authorize_user!, only: [:destroy]


  def create
    @review = Review.new(review_params)
    @review.product = @product
    @review.user = current_user

    if @review.save
      redirect_to product_path(@product)
    else
      @reviews = @product.reviews.order(created_at: :desc)
      render 'products/show'
    end
  end


  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to product_path(@product)
  end

  def hidden_review

  end
  
  private
  def review_params
    params.require(:review).permit(:body, :rating)
  end

  def find_product
    @product = Product.find params[:product_id]
  end


  def find_review
    @review = Review.find params[:id]
  end

  def authorize_user!
    unless can?(:manage, @review)
      flash[:alert] = "Access Denied!"
      redirect_to home_path
    end
  end
end
