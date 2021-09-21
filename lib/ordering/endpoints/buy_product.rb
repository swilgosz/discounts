# frozen_string_literal: true

require 'ordering/events/item_added_to_basket'

module Ordering
  module Endpoints
    class BuyProduct
      def call(order:, product:)
        line_item = LineItem.create(order_id: order, product_id: product, quantity: 1)
        publish_event(line_item)
      end

      private

      attr_reader :event_store

      def initialize(event_store:)
        @event_store = event_store
      end

      def publish_event(line_item)
        event = Ordering::Events::ItemAddedToBasket.new(
          data: {
            order_id: line_item.order_id,
            product_code: line_item.product.code,
            quantity: 1
          }
        )

        stream_name = "Order$#{line_item.order_id}"
        event_store.publish(event, stream_name: stream_name)
      end
    end
  end
end
