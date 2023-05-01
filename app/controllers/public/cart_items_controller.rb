class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @cart_items = CartItem.all
  end
  
  def create
    cart_item = CartItem.new(cart_item_params)
    cart_item.customer_id = current_customer.id
    cart_item = current_customer.cart_items.find_by(item_id:)
    if cart_item
      cart_item += cart_items.amount.to_i
    else
      cart_item.save
    end
  end
  
  def update
    cart_item = CartItem.find(params[:item_id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end
  
  def destroy
    cart_item = CartItem.find(params[:item_id])
    cart_item.destroy
    redirect_to cart_items_path
  end
  
  def destroy_all
    @cart_items = CartItem.all
    @cart_items.destroy_all
    redirect_to cart_items_path
  end
  
  private
  
  def cart_items_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
