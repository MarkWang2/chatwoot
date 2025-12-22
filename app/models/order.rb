# == Schema Information
#
# Table name: orders
#
#  id              :uuid             not null, primary key
#  amount          :decimal(, )
#  currency        :string
#  order_type      :string
#  payment_address :string
#  payment_type    :string
#  status          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :bigint
#
# Indexes
#
#  index_orders_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Order < ApplicationRecord
  has_and_belongs_to_many :accounts, join_table: :accounts_orders
end
