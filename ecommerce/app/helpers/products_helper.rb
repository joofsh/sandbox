module ProductsHelper

  def print_price(price)
    number_to_currency price
  end

 def print_stock(stock)
   if stock > 0
     return stock
   else
     return "Out of Stock"
   end
 end




end
