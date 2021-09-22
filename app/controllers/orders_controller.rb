class OrdersController < ApplicationController
  # GET /orders
  def index
    @orders = Order.includes(line_items: :product).where(status: :closed)
  end

  # PATCH /order/close
  def close
    endpoint = Ordering::Endpoints::CloseOrder.new(event_store: Rails.configuration.event_store)
    endpoint.call
    redirect_to orders_url, notice: 'Your order had been successfully closed'
  end
end
