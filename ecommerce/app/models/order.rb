class Order < ActiveRecord::Base
  attr_accessible :customer_id, :status

  has_many :order_items, :dependent => :destroy

  def total
    total = 0
      self.order_items.each do |a|
        total += a.subtotal
    end
    total
  end

end
