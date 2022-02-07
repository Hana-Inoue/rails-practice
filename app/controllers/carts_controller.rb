class CartsController < ApplicationController
  def show
    return @cart = [] if session[:cart].nil?
    @cart = session[:cart]
      .group_by(&:itself)
      .map { |key, value| [Product.find(key.to_i), value.count] }
      .to_h
  end

  def create
    session[:cart] ||= []
    session[:cart].unshift(params[:product_id])
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
