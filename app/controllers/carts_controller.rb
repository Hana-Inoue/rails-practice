class CartsController < ApplicationController
  def show
    return @products = [] if session[:cart].nil?
    @products = session[:cart].map(&:to_i).map { |product_id| Product.find(product_id) }
  end

  def create
    session[:cart] ||= []
    session[:cart].unshift(params[:product_id])
    redirect_to products_path,
                notice: t('layouts.flash.messages.added_to_cart',
                          product: Product.find(params[:product_id]).name)
  end

  def destroy
  end
end
