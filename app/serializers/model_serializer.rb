class ModelSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :generation
end

