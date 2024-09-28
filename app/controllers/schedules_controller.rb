class SchedulesController < ApplicationController
  def index
    @schedules = Schedule.all
  end

  def new
    @schedule = Schedule.new(attr_params)
  end

  def create
    @schedule = Schedule.new(attr_params)
    if @schedule.save
      redirect_to edit_schedule_path(@schedule)
    else
      render :new
    end
  end

  Truck = Struct.new(:id, keyword_init: true)

  def edit
    @schedule = Schedule.find(params[:id])
    @trucks = (1..3).map { Truck.new(id: _1) }

    day = @schedule.date.strftime("%A")
    @dogs = Dog.where(day => true)
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(attr_params)
      redirect_to schedules_path
    else
      render :edit
    end
  end

  private
    def attr_params
      params.fetch(:schedule, {}).then { |p|
        p.permit(
          :date,
          assignments: p.dig(:assignments)&.keys
        )
      }
    end
end
