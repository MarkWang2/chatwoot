class UpdateOrdersPaymentFields < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :currency, :string
    rename_column :orders, :address, :payment_address
  end
end
