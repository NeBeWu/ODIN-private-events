class EventsController < ApplicationController
  before_action :set_event, only: %i[show subscribe unsubscribe]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @events = Event.all
  end

  def show; end

  def new
    @new_event = current_user.events.build
  end

  def create
    @new_event = current_user.events.build(event_params)

    if @new_event.save
      redirect_back_or_to :root, notice: 'Event was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def subscribe
    if request.post?
      @event.attendees << current_user

      redirect_to event_path(@event.id), notice: 'Successfully subscribed to event.'
    else
      render :show, status: :unprocessable_entity
    end
  end

  def unsubscribe
    if request.delete?
      @event.attendees.delete current_user

      redirect_to event_path(@event.id), notice: 'Successfully unsubscribed to event.'
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:title, :description, :date, :location, :price)
  end
end
