class Credit < ApplicationRecord
    belongs_to :car 
    belongs_to :bank
    belongs_to :program
end
