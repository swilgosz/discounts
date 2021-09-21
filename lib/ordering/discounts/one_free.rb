# frozen_string_literal: true

module Ordering
  module Discounts
    class OneFree
      def call(line_items)
        items = line_items.to_a
        teas = items.select { |i| tea?(i) }

        free = items.select { |i| discount_applied?(i) }
        return if teas.length <= 1 && free.none?

        items.last.update(price: 0) if free.none?

        if free.length == 1 && items.length == 1
          (item = items.first).update(price: item.product.price)
        end
      end

      private

      def tea?(item)
        item.product.code == 'GR1'
      end

      def discount_applied?(item)
        tea?(item) && item.price == 0
      end
    end
  end
end
