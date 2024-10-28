class CarSerializer < ActiveModel::Serializer
  attributes :id, :year, :price, :description

  has_many :images
  has_many :history_cars
  belongs_to :brand
  belongs_to :model
  belongs_to :generation
  belongs_to :color
  belongs_to :body_type
  belongs_to :engine_type
  belongs_to :gearbox_type
  belongs_to :drive_type
end
