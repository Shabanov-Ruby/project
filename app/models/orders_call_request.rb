class OrdersCallRequest < ApplicationRecord
  belongs_to :call_request
  belongs_to :order_status
end
