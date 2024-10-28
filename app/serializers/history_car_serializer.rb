class HistoryCarSerializer < ActiveModel::Serializer
  attributes :id, :vin, :last_mileage, :previous_owners
end
