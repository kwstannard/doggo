class DropoffsController < ApplicationController
  def create
    dropoff = Dropoff.create!(attr_params)
    redirect_to edit_trip_path(dropoff.trip)
  end

  def attr_params
    params.fetch(:dropoff, {}).permit(:dog_id, :trip_id)
  end
end
