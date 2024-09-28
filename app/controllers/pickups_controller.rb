class PickupsController < ApplicationController
  def create
    pickup = Pickup.create!(attr_params)
    redirect_to edit_trip_path(pickup.trip)
  end

  def attr_params
    params.fetch(:pickup, {}).permit(:dog_id, :trip_id)
  end
end
