class LikesController < ApplicationController
before_action :authenticate_user!

  def create
    review = Like.find params[:review_id]
    product = review.product
    like = Like.new(review: review, user: current_user)
    # like = current_user.likes.new
    like.review = review
    if like_save
      redirect_to product, success: 'Liked'
    else
      redirect_to product, danger: "Couldn't like"
    end
  end

  def destroy
    like = Like.find params[:id]
    product = like.review.product
    like.destroy
    redirect_to product, success: 'Like removed'
  end

end
