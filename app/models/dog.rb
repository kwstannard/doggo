class Dog < ApplicationRecord
  has_many :pickups

  def trip_for_today
    Trip.where(date: Date.current).detect { |trip|
      trip.dogs.include?(self)
    }
  end

  def weekly_schedule
    Date::DAYNAMES[1..-2].select { attribute(_1) }
  end

  def status
    trip = trip_for_today
    return "At Home" unless trip

    pickup = trip.pickups.find_by(dog: self)
    dropoff = trip.dropoffs.find_by(dog: self)

    case
    when dropoff       then "Dropped Off"
    when trip.departed then "Departed"
    when trip.arrived  then "Arrived"
    when pickup        then "Picked Up"
    else                    "At Home"
    end
  end
end
