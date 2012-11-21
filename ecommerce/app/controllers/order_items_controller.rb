class OrderItemsController < ApplicationController
  before_filter :load_order

  def create
    @order_item = @order.order_items.find_or_initialize_by_product_id(params[:product_id])
    @order_item.quantity += 1
    if valid_quantity 
      @order_item.save
      redirect_to @order
      flash[:message] = "Successfully created order item."
    else
      redirect_to products_path
      
    end
  end

  def edit
    @order_item = OrderItem.find(params[:id])
  end

  def update
    @order_item = OrderItem.find(params[:id])
    if valid_quantity
      @order_item.update_attributes(params[:order_item])
    end
    
    if @order_item.quantity <= 0
      self.delete_item
    else
      redirect_to @order
      flash[:message]  = "Successfully updated Quantity."
    end
  end

  def destroy
    self.delete_item
  end
end

 def valid_quantity
  @update_product = Product.find(@order_item.product_id)
  #@stock_difference =
  if @order_item.quantity <= @update_product.stock 
    @update_product.stock -= @order_item.quantity
    return true
  else 
  flash[:message] = "Insufficient inventory to process that order"
  return false
    end
  end
