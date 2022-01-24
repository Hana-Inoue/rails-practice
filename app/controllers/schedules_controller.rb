class SchedulesController < ApplicationController
  def index
    @pages, @schedules = paginate(active_record: Schedule.all)
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def new
    @schedule = Schedule.new
  end

  def edit
  end

  def create
    @schedule = Schedule.new(schedule_params)

    if @schedule.save
      redirect_to @schedule, notice: t('layouts.flash.messages.created_schedule')
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def schedule_params
    params
      .require(:schedule)
      .permit(:name, :scheduled_for, :scheduled_by)
  end
end
