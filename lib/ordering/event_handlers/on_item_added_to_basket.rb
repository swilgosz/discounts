# frozen_string_literal: true

module Ordering
  module EventHandlers
    class OnItemAddedToBasket
      def call(event)
        line_item = create_item(event.data)
      end

      private

      def create_item(data)
        product = Product.find_by(code: data[:product_code])
        LineItem.create(
          order_id: data[:order_id],
          product_id: product.id,
          quantity: data[:quantity]
        )
      end
    end
  end
end
