# frozen_string_literal: true

module Ordering
  module Endpoints
    class BuyProduct
      def call(order:, product:)
        LineItem.create(order_id: order, product_id: product, quantity: 1)
      end
    end
  end
end
