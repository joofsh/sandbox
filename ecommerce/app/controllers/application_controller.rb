class ApplicationController < ActionController::Base
  protect_from_forgery

  def load_order
    @order = Order.find_or_initialize_by_id(session[:order_id], :status => "unsubmitted")
    if @order.new_record?
      @order.save!
      session[:order_id] = @order.id
    end
  end

  def delete_item
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
    redirect_to @order
    flash[:message] = "Successfully removed item from cart"
  end

end
