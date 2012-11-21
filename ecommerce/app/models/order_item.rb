class OrderItem < ActiveRecord::Base
  attr_accessible :product_id, :order_id, :quantity

  belongs_to :product
  belongs_to :order

  validates_presence_of :product_id, :order_id
  validates_numericality_of :quantity, :message => "Must be a number 0-9999", :greater_than_or_equal_to => 0


def validates_valid_quantity quantity



end

 

  def subtotal
    self.quantity * Product.find(self.product_id).price
  end


end
