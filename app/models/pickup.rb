class Pickup < ApplicationRecord
  belongs_to :dog, required: true
  belongs_to :trip, required: true
end
