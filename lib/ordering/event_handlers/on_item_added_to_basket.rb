# frozen_string_literal: true

module Ordering
  module EventHandlers
    class OnItemAddedToBasket
      def call(event)
        order =
          case event.event_type
          when "Ordering::Events::ItemAddedToBasket"
            line_item = create_item(event.data)
            line_item.order
          when "Ordering::Events::ItemRemoved"
            line_item = LineItem.find(event.data[:item_id])
            line_item.destroy
            line_item.order
          end
        apply_discounts(line_item.order)
        calculate_total(line_item.order)
      end

      private

      def create_item(data)
        product = Product.find_by(code: data[:product_code])
        LineItem.create(
          order_id: data[:order_id],
          product_id: product.id,
          price: data[:price],
          quantity: data[:quantity]
        )
      end

      def apply_discounts(order)
        DiscountsRepository.new.all.each do |discount|
          discount.call(order.line_items.includes(:product))
        end
      end

      def calculate_total(order)
        total =
          order.line_items.
            map { |li| li.quantity * li.price }.sum
        order.update(total: total)
      end
    end
  end
end
