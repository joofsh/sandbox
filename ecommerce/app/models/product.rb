class Product < ActiveRecord::Base
  attr_accessible :title, :price, :description, :image_url, :stock

 has_many :order_items

  def price=(input)
    input.delete!("$")
    super
  end

  validates_numericality_of :price
  validates_numericality_of :stock, :message => "Must be a number 0-9999", :greater_than_or_equal_to => 0

end
