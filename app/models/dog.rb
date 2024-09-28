class Dog < ApplicationRecord
  def weekly_schedule
    Date::DAYNAMES[1..-2].select { attribute(_1) }
  end
end
