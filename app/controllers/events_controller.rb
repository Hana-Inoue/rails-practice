class EventsController < ApplicationController
  def index
    @events_search_params = events_search_params
    @pages, @events = paginate(active_record: Event.order(:id))
  end

  def show
    @event = find_event
  end

  def new
    @event = Event.new
  end

  def edit
    @event = find_event
  end

  def search
    @events_search_params = events_search_params
    @pages, @events = paginate(active_record: Event.search(@events_search_params).order(:id))

    render :index
  end

  def create
    @event = Event.new(event_params)

    redirect_to @event, notice: t('layouts.flash.messages.created_event') and return if @event.save
    render :new
  end

  def update
    @event = find_event

    if @event.update(event_params)
      redirect_to @event, notice: t('layouts.flash.messages.updated_event') and return
    end
    render :edit
  end

  def destroy
    event = find_event

    event.destroy
    redirect_to events_path, notice: t('layouts.flash.messages.deleted_event', title: event.title)
  end

  private

  def find_event
    Event.find(params[:id])
  end

  def event_params
    params
      .require(:event)
      .permit(:title, :body, :max_participants, :start_at, :finish_at)
      .merge(host: current_user.name)
  end

  def events_search_params
    params
      .fetch(:search, {})
      .permit(:title, :start_at, :finish_at, :min_max_participants, :body, :host)
  end
end
