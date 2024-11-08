FactoryBot.define do
  factory :order do
    buyout { nil }
    credit { nil }
    exchange { nil }
    installment { nil }
    call_request { nil }
    order_status { nil }
    description { "MyString" }
  end
end
