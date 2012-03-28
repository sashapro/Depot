class StoreController < ApplicationController
  def index
    @products = Product.order(:price)
    @count = increment_count
  end
end
