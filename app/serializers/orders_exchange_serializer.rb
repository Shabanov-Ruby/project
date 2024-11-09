class OrdersExchangeSerializer < ActiveModel::Serializer
  attributes :id, :description
  has_one :exchanges
  has_one :order_status
end
