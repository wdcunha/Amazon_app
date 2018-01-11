class FavouritesController < ApplicationController
  def create
    product = Product.find params[:product_id]
    favourite = product.favourites.new
    # favourite = Favourite.new
    # favourite.product = product
    favourite.user = current_user
    favourite.save
    redirect_to product  end

  def destroy
    favourite = Favourite.find params[:id]
    product = favourite.product
    favourite.destroy
    redirect_to product

  end

  def index
    @favourites = current_user.favourited_products
  end
  
end
