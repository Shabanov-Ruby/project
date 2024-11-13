class OrdersExchange < ApplicationRecord
  belongs_to :exchanges
  belongs_to :order_status
  belongs_to :car
end
