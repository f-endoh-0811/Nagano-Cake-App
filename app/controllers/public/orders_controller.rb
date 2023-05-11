class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses.all
  end

  def index
    @orders = current_customer.orders.all
    @order_details = OrderDetail.all
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details.all
    @total = @order.billing_amount - @order.postage # 商品合計金額
  end

  def check
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @billing_amount = @total + @order.postage #請求金額を算出
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "2"
      @order.postal_code = order_params[:postal_code]
      @order.address = order_params[:address]
      @order.name = order_params[:name]
    else
      render :new
    end
  end

  def create
    @order = current_customer.orders.new(order_params)
    cart_items = current_customer.cart_items.all
    if @order.save
      cart_items.each do |cart_item| #カート内の商品データをOrderDetailモデルに送る
        order_detail = OrderDetail.new
        order_detail.order_id = @order.id
        order_detail.item_id = cart_item.item_id
        order_detail.price = cart_item.item.with_tax_price
        order_detail.amount = cart_item.amount
        order_detail.save
        cart_items.destroy_all
      end
      redirect_to thanks_orders_path
    else
      render :new
    end
  end

  def thanks
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :postage, :billing_amount)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end
end
