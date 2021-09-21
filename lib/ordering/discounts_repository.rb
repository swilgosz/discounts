# frozen_string_literal: true

module Ordering
  class DiscountsRepository
    def all
      [
        Discounts::OneFree.new,
        Discounts::CheaperStrawberries.new
      ]
    end
  end
end
