class Installment < ApplicationRecord
    has_one :car
    has_many :orders_installments
end
