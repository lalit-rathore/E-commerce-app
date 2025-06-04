class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart 
  def create
    item = @cart.cart_items.find_or_initialize_by(product_id: params[:product_id])
    item.quantity ||= 0
    item.quantity += params[:quantity].to_i
    item.save!
    redirect_to cart_path, notice: 'Item added to cart'
  end

  def update
    item = @cart.cart_items.find(params[:id])
    item.update(quantity: params[:quantity])
    redirect_to cart_path, notice: 'Item updated'
  end

  def destroy
    @cart.cart_items.find(params[:id])&.destroy
    redirect_to cart_path, notice: 'Item Removed'
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
