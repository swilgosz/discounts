# frozen_string_literal: true

require 'ordering/events/item_added_to_basket'

module Ordering
  module Endpoints
    class BuyProduct
      def call(order:, product:)
        publish_event(order, product)
      end

      private

      attr_reader :event_store

      def initialize(event_store:)
        @event_store = event_store
      end

      def publish_event(order_id, product_code)
        event = Ordering::Events::ItemAddedToBasket.new(
          data: {
            order_id: order_id,
            product_code: product_code,
            quantity: 1
          }
        )

        stream_name = "Order$#{order_id}"
        event_store.publish(event, stream_name: stream_name)
      end
    end
  end
end
