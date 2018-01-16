# class LikesController < ApplicationController
# before_action :authenticate_user!
#
#   def create
#     review = Like.find params[:review_id]
#     product = review.product
#     like = Like.new(review: review, user: current_user)
#     # like = current_user.likes.new
#     like.review = review
#     if like_save
#       redirect_to product, success: 'Liked'
#     else
#       redirect_to product, danger: "Couldn't like"
#     end
#   end
#
#   def destroy
#     like = Like.find params[:id]
#     product = like.review.product
#     like.destroy
#     redirect_to product, success: 'Like removed'
#   end
#
# end

class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:destroy]

  def create
    # @product = Product.find params[:product_id]
    review = Review.find params[:review_id]
    product = review.product
    if can?(:like, review)
      like = current_user.likes.new
      # like = Like.new
      # like.user = current_user
      like.review = review
      if like.save
        # redirect_to review_path(r), notice: 'Liked'
        redirect_to product, notice: 'Liked'
      else
        redirect_to product, alert: 'Couldn\'t like'
      end
    end
  end

  def destroy
    like = Like.find params[:id]
    product = like.review.product
    like.destroy
    # redirect_to product
    redirect_to product, notice: 'Like removed'
  end

  private

  def authenticate_user!
    redirect_to root_path unless user_signed_in?
  end

  def authorize_user!
    like = Like.find params[:id]
    product = like.review.product
    redirect_to product unless can?(:destroy, like)
  end

end
