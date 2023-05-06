class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def index
  end

  def show
  end
  
  def check
    @order = Order.new(order_params)
  end
  
  def create
  end
  
  def thanks
  end
  
  private
  
  def order_params
    params.require(:order).permit()
  end
end
