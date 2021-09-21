class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  monetize :price_cents
end
