class Order < ApplicationRecord
  
  belongs_to :customer
  has_many :order_details
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  
  def postage
    800
  end
  
  def billing_amount
    cart_item.subtotal + postage
  end
end
