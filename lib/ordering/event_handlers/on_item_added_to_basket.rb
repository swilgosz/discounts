# frozen_string_literal: true

module Ordering
  module EventHandlers
    class OnItemAddedToBasket
      def call(event)
        line_item = create_item(event.data)
        calculate_total(line_item.order)
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

      def calculate_total(order)
        total =
          order.line_items.includes(:product).
            map { |li| li.quantity * li.product.price }.sum
        order.update(total: total)
      end
    end
  end
end
