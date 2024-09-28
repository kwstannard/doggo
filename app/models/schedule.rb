class Schedule < ApplicationRecord
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
end
