# frozen_string_literal: true

module Ordering
  module Discounts
    class CheaperStrawberries
      def call(line_items)
        items = line_items.to_a
        strawberries = items.select { |i| strawberry?(i) }

        if strawberries.length < 3
          strawberries.each { |sr| sr.update(price: sr.product.price) }
        else
          strawberries.each { |sr| sr.update(price: 4.50) }
        end
      end

      private

      def strawberry?(item)
        item.product.code == 'SR1'
      end
    end
  end
end
