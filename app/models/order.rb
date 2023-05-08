class Order < ApplicationRecord
  
  belongs_to :customer
  has_many :order_details
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  
  # 送料
  def postage
    800
  end
  
  def total_amount
    total_amount = 0
    order_details.each do |order_detail|
      total_amount += order_detail.amount
    end
    return total_amount
  end
  
end
