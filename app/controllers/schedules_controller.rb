class SchedulesController < ApplicationController
  # SQL Injection が発生しないアクション
  def index
    @pages, @schedules = paginate(active_record: Schedule.all)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
