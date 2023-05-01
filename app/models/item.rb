class Item < ApplicationRecord
  
  has_one_attached :image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details
  
  def get_image(width, height)
    image.variant(resize_to_fill: [width, height]).processed
  end
  
  # 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end
end
