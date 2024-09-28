class Schedule < ApplicationRecord
  has_many :trips, foreign_key: :date
  validates :date, presence: true

  before_save do
    write_attribute(:raw_assignments, assignments.to_json)
  end

  def name
    date.strftime("%A")
  end

  def assignments
    @assignments ||= JSON.parse(raw_assignments)
  end

  def assignments=(hash)
    @assignments = hash.compact
  end

  def dogs
    assignments.keys
  end

  def trucks
    assignments.values.uniq
  end

  def truck_assignments
    assignments.reduce(Hash.new { |h, k| h[k] = [] }) { |agg, (dog_id, truck_id)| agg.tap { |a|  a[truck_id] << dog_id } }
  end
end
