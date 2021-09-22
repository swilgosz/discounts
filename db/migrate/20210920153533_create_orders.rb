class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.monetize :total
      t.integer :status

      t.timestamps
    end
  end
end
