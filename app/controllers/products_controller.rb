class ProductsController < ApplicationController
  def index
    @pages, @products = paginate(active_record: Product.all)
  end
end
