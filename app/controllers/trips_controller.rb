class TripsController < ApplicationController
  def new
    @trip = Trip.new(date: Date.current)
  end

  def create
    @trip = Trip.new(attr_params)
    @trip.save!
    redirect_to edit_trip_path(@trip)
  end

  def edit
    @trip = Trip.find(params[:id])
    if @trip.arrived && @trip.departed
    elsif @trip.arrived
      @trip.departed = true
    else
      @trip.arrived = true
    end
  end

  def update
    @trip = Trip.find(params[:id])
    @trip.update!(attr_params)
    redirect_to edit_trip_path(@trip)
  end

  private

    def attr_params
      params.fetch(:trip, {}).permit(:date, :truck_id, :arrived, :departed)
    end
end
