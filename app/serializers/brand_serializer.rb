class BrandSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :models
end




