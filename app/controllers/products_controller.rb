class ProductsController < ApplicationController
  def index
    @pages, @products = paginate(active_record: Product.all)
  end

  def add_product_to_cart
    session[:cart] ||= []
    session[:cart] << params[:id]
    redirect_to products_path,
                notice: t('layouts.flash.messages.added_to_cart',
                        product: Product.find(params[:id]).name)
  end

  def show_cart
    return @products = nil if session[:cart] == nil
    @products = session[:cart].map(&:to_i).map { |cart_id| Product.find(cart_id) }
  end
end
