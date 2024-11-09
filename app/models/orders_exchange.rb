class OrdersExchange < ApplicationRecord
  belongs_to :exchanges
  belongs_to :order_status
end
