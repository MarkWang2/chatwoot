# == Schema Information
#
# Table name: orders
#
#  id           :bigint           not null, primary key
#  address      :string
#  amount       :decimal(, )
#  order_type   :string
#  payment_type :string
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Order < ApplicationRecord
  has_and_belongs_to_many :accounts, join_table: :accounts_orders
end
