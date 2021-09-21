# frozen_string_literal: true

module Ordering
  module Discounts
    class CheaperCoffee
      def call(line_items)
        items = line_items.to_a
        coffees = items.select { |i| coffee?(i) }

        if coffees.length < 3
          coffees.each { |sr| sr.update(price: sr.product.price) }
        else
          coffees.each { |sr| sr.update(price: sr.product.price*2/3) }
        end
      end

      private

      def coffee?(item)
        item.product.code == 'CF1'
      end
    end
  end
end
