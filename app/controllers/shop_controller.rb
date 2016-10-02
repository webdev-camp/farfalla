class ShopController < ApplicationController

  def index
    @root = Category.find_by_name "Luomukosmetiikka"
  end

  def show
    @category = Category.find(params[:id])
    if @category.categories.length == 0
      render "display_products"
    else
      render "display_subcategories"
    end
  end

  def show_product
    @show_product = Product.find(params[:id])
  end

end
