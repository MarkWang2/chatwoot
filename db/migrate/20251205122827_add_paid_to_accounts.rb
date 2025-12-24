class AddPaidToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :paid, :boolean, default: false
  end
end
