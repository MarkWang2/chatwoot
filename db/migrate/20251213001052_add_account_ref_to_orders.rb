class AddAccountRefToOrders < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :account, null: true, foreign_key: true
  end
end
