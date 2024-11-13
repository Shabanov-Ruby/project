class OrdersCredit < ApplicationRecord
  belongs_to :credit
  belongs_to :order_status
  belongs_to :car
  belongs_to :bank
  belongs_to :program
end
