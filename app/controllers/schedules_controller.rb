class SchedulesController < ApplicationController
  # SQL Injection が発生しないアクション
  def index
    @pages, @schedules = paginate(active_record: Schedule.all)
  end

  # SQL Injection が発生するアクション
  # url :id 部分に 1) OR 1=1-- と入力することで全スケジュール詳細を表示
  def show
    @schedules = Schedule.where("id = #{params[:id]}")
  end

  # SQL Injection が発生しないアクション
  def new
    @schedule = Schedule.new
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
