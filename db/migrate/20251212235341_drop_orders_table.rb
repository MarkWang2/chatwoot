class DropOrdersTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :orders
  end

  def down
    create_table :orders do |t|
      t.timestamps
    end
  end
end
