class CartsController < ApplicationController
  def show
    return @cart = [] if session[:cart].nil?
    @cart = session[:cart].map(&:to_i).map { |product_id| Product.find(product_id) }
  end

  def create
    session[:cart] ||= []
    session[:cart].unshift(params[:product_id]).uniq!
    redirect_to products_path,
                notice: t('layouts.flash.messages.added_product_to_cart',
                          product: Product.find(params[:product_id]).name)
  end

  def destroy
    session[:cart].delete(params[:product_id])
    redirect_to cart_path,
                notice: t('layouts.flash.messages.deleted_product_from_cart',
                          product: Product.find(params[:product_id].to_i).name)
  end
end
