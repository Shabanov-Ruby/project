class Order < ApplicationRecord
  belongs_to :buyout
  belongs_to :credit
  belongs_to :exchange
  belongs_to :installment
  belongs_to :call_request
  belongs_to :order_status

  validates :buyout_id, :credit_id, :exchange_id, :installment_id, :call_request_id, :order_status_id, default: nil
end
