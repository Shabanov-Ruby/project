class OrdersCreditSerializer < ActiveModel::Serializer
  attributes :id, :description
  has_one :credit
  has_one :order_status
  has_one :car
  has_one :bank
  has_one :program
end
