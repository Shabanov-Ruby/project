class CallRequest < ApplicationRecord
  belongs_to :car, optional: true
end

