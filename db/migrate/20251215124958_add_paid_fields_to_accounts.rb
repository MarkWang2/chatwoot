class AddPaidFieldsToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :paid_at, :datetime
    add_column :accounts, :paid_until, :datetime
  end
end
