class ShopController < ApplicationController

  def index
    @root = Category.find_by_name "Luomukosmetiikka"
  end
end
