class Model < ApplicationRecord
  belongs_to :brand
  has_many :generation
  has_many :cars
  
end
