class ImageSerializer < ActiveModel::Serializer
  attributes :id, :url, :is_primary
end
