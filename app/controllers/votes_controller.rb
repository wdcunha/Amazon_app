class VotesController < ApplicationController

  def create
    review = Review.find params[:review_id]
    product = review.product
    vote = Vote.new(user: current_user, review: review, is_up: params[:is_up])
    if vote.save
      redirect_to product, success: 'Thanks for voting!'
    else
      redirect_to product, danger: 'Could not vote!!!'
    end
  end

  def update
    vote = Vote.find params[:id]
    product = vote.review.product
    vote.update({ is_up: params[:is_up]})
    redirect_to product, success: 'Vote changed!'
  end

  def destroy
    vote = Vote.find params[:id]
    vote.destroy
    redirect_to vote.review.product, danger: 'Vote Removed!'
  end

end
