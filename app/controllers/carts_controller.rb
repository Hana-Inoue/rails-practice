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
                notice: t('carts.flash.messages.added_product',
                          product: Product.find(params[:product_id]).name)
  end

  def destroy
    session[:cart].delete_at(session[:cart].index(params[:product_id]))
    redirect_to cart_path,
                notice: t('carts.flash.messages.deleted_product',
                          product: Product.find(params[:product_id].to_i).name)
  end
end
