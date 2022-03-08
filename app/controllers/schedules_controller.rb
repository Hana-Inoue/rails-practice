class SchedulesController < ApplicationController
  def index
    @schedules_search_params = schedules_search_params
    @schedules_sql_injection_search_params = schedules_sql_injection_search_params
    @schedules = Schedule.all
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def new
    @schedule = Schedule.new
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def search
    @schedules_search_params = schedules_search_params
    @schedules_sql_injection_search_params = schedules_sql_injection_search_params
    @schedules = Schedule.search(@schedules_search_params).order(:id)

    render :index
  end

  def sql_injection_search
    @schedules_search_params = schedules_search_params
    @schedules_sql_injection_search_params = schedules_sql_injection_search_params
    @schedules = Schedule.sql_injection_search(@schedules_sql_injection_search_params).order(:id)

    render :index
  end

  def create
    @schedule = Schedule.new(schedule_params)

    if @schedule.save
      redirect_to @schedule, notice: t('schedules.flash.messages.created')
    else
      render :new
    end
  end

  def update
    @schedule = Schedule.find(params[:id])

    if @schedule.update(schedule_params)
      redirect_to @schedule, notice: t('schedules.flash.messages.updated')
    else
      render :edit
    end
  end

  def destroy
    schedule = Schedule.find(params[:id])

    schedule.destroy
    redirect_to schedules_path, notice: t('schedules.flash.messages.deleted', name: schedule.name)
  end

  private

  def schedule_params
    params
      .require(:schedule)
      .permit(:name, :scheduled_for, :scheduled_by)
  end

  def schedules_search_params
    params
      .fetch(:search, {})
      .permit(:name)
  end

  def schedules_sql_injection_search_params
    params
      .fetch(:sql_injection_search, {})
      .permit(:name)
  end
end
