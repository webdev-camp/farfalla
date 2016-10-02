class ShopController < ApplicationController

  def index
    @root = Category.find_by_name "Luomukosmetiikka"
  end

  def show
    @category = Category.find(params[:id])
  end

  def show_product
    @show_product = Product.find(params[:id])
  end

end
