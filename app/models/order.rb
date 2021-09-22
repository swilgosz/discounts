class Order < ApplicationRecord
  monetize :total_cents

  enum status: { open: 1, closed: 2 }

  has_many :line_items, dependent: :destroy
end
