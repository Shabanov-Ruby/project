class OrderSerializer < ActiveModel::Serializer
  attributes :id, :description
  has_one :buyout
  has_one :credit
  has_one :exchange
  has_one :installment
  has_one :call_request
  has_one :order_status
end
