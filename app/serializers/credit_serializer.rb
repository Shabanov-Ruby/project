class CreditSerializer < ActiveModel::Serializer
  attributes :id, :car_id, :name, :phone, :credit_term, :initial_contribution, :banks_id, :programs_id
  has_one :car
  has_one :bank
  has_one :program
end
