class OrdersInstallment < ApplicationRecord
  belongs_to :installment
  belongs_to :order_status
  belongs_to :car
end
