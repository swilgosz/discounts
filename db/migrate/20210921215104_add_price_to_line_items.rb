class AddPriceToLineItems < ActiveRecord::Migration[6.1]
  def change
    add_monetize :line_items, :price
  end
end
