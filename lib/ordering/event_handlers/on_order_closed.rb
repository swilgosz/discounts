# frozen_string_literal: true

module Ordering
  module EventHandlers
    class OnOrderClosed
      def call(event)
        order = Order.find(event.data[:order_id])
        order.update(status: :closed)
      end
    end
  end
end
