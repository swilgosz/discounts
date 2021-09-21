# frozen_string_literal: true

require 'ordering/events/item_added_to_basket'

module Ordering
  module Endpoints
    class RemoveItem
      def call(item_id)
        # validate request parameters
        # authorize
        publish_event(item_id)
        # return success/failure value
      end

      private

      attr_reader :event_store

      def initialize(event_store:)
        @event_store = event_store
      end

      def publish_event(item_id)
        event = Ordering::Events::ItemRemoved.new(
          data: { item_id: item_id }
        )

        stream_name = "LineItem$#{item_id}"
        event_store.publish(event, stream_name: stream_name)
      end
    end
  end
end
