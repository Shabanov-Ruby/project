class ExtraSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :car
  has_one :category
end
