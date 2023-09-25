class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @total = @order.billing_amount - @order.postage # 商品合計金額
  end
end
