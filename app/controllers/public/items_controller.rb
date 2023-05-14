class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8)
    @item_all = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end
  
  # 検索窓
  def search
    @items = Item.search(params[:keyword]).order(created_at: :desc)
  end
end
