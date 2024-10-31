class Car < ApplicationRecord
  belongs_to :brand
  belongs_to :model
  belongs_to :generation
  
  belongs_to :color
  belongs_to :body_type
  belongs_to :engine_type
  belongs_to :gearbox_type
  belongs_to :drive_type
  
  has_many :call_requests
  has_many :history_cars
  has_many :images

  has_many :extras
  has_many :categories, through: :extras

  has_one :history_car

  scope :by_brand_name, -> (brand_name) { joins(model: :brand ).where(brands: { name: brand_name }) if brand_name.present? }
  scope :by_model_name, -> (model_name) { joins(:model).where(models: { name: model_name }) if model_name.present? }
  scope :by_generation, -> (generation_name) { joins(:generation).where(generations: { name: generation_name }) if generation_name.present? }

  scope :by_year_from, -> (year) { where('year >= ?', year) }
  scope :by_price, -> (max_price) { where('price <= ?', max_price) if max_price.present? }
  
  scope :by_gearbox_type, -> (gearbox_type_id) { where(gearbox_type_id: gearbox_type_id) if gearbox_type_id.present? }
  scope :by_body_type, -> (body_type_id) { where(body_type_id: body_type_id) if body_type_id.present? }
  scope :by_drive_type, -> (drive_type_id) { where(drive_type_id: drive_type_id) if drive_type_id.present? }
  scope :by_owners_count, -> (owners_count) { where(owners_count: owners_count) if owners_count.present? }

  scope :by_owners_count, -> (owners_count) { joins(:history_cars).where(history_cars: { previous_owners: owners_count }) if owners_count.present? }
 
  scope :by_engine_type_name, -> (engine_type_name) {
    joins(:engine_type).where(engine_types: { name: engine_type_name }) if engine_type_name.present?
  }

  belongs_to :generation
end
