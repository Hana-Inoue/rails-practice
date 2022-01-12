class EventsController < ApplicationController
  def index
    @pages, @events = paginate(active_record: Event.order(:id))
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
