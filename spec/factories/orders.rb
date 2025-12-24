FactoryBot.define do
  factory :order do
    payment_type { "MyString" }
    amount { "9.99" }
    status { "MyString" }
    address { "MyString" }
    order_type { "MyString" }
  end
end
