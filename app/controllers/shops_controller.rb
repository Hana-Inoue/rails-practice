class ShopsController < ApplicationController
  def index
    @shop_products_unnormalized = ShopProductUnnormalized.all
    @shops = Shop.all
    @shop_products = ShopProduct.all
  end
end
