class OrdersExchangeSerializer < ActiveModel::Serializer
  attributes :id, :description
  has_one :exchange
  has_one :order_status
end
