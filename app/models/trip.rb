class Trip < ApplicationRecord
  belongs_to :schedule, primary_key: :date, foreign_key: :date
  has_many :pickups
  has_many :dropoffs

  delegate :truck_assignments, to: :schedule

  def dogs
    Dog.find(schedule.truck_assignments[truck_id.to_s])
  end
end
