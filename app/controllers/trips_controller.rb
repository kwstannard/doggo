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
  end

  def update
    @trip = Trip.find(params[:id])
    @trip.update!(attr_params)
    redirect_to edit_trip_path(@trip)
  end

  private

    def attr_params
      params.fetch(:trip, {}).permit(:date, :truck_id, :arrived, :departed).tap {|p|
        case params[:commit]
        when 'Arrived'
          p[:arrived] = true
        when 'Departed'
          p[:departed] = true
        end
      }
    end
end
