class ApplicationController < ActionController::Base
  before_action :fetch_order

  def fetch_order
    @order = Order.find_or_create_by(status: :open)
  end
end
