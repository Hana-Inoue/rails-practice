class EventsController < ApplicationController
  def index
    @pages, @events = paginate(active_record: Event.order(:id))
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event, notice: t('layouts.flash.messages.created_event')
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end
end
