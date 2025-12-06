class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :payment_type
      t.decimal :amount
      t.string :status
      t.string :address
      t.string :order_type

      t.timestamps
    end
  end
end
