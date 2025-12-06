class CreateJoinTableAccountsOrders < ActiveRecord::Migration[7.1]
  def change
    create_join_table :accounts, :orders do |t|
      # t.index [:account_id, :order_id]
      # t.index [:order_id, :account_id]
    end
  end
end
