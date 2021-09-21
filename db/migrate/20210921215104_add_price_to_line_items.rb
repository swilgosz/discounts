class AddPriceToLineItems < ActiveRecord::Migration[6.1]
  def change
    add_money :line_items, :price
  end
end
