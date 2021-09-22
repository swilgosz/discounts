# frozen_string_literal: true

require 'ordering/events/item_added_to_basket'

module Ordering
  module Endpoints
    class CloseOrder
      def call
        # validate request parameters
        # authorize
        return unless order = fetch_opened_order
        publish_event(order.id)
        # return success/failure value
      end

      private

      attr_reader :event_store

      def initialize(event_store:)
        @event_store = event_store
      end

      def fetch_opened_order
        Order.where(status: :open).first
      end

      def publish_event(order_id)
        event = Ordering::Events::OrderClosed.new(
          data: {
            order_id: order_id,
          }
        )

        stream_name = "Order$#{order_id}"
        event_store.publish(event, stream_name: stream_name)
      end
    end
  end
end
