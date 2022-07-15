class EventsController < ApplicationController
  before_action :set_event, except: %i[index new create]
  before_action :authenticate_user!, except: %i[index show]
  before_action :authorize_user, only: %i[edit update destroy]

  def index
    @events = Event.all
  end

  def show; end

  def new
    @new_event = current_user.created_events.build
  end

  def create
    @new_event = current_user.created_events.build(event_params)

    if @new_event.save
      redirect_to :root, notice: 'Event was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @event.assign_attributes(event_params)

    if @event.save
      redirect_to event_path(@event.id), notice: 'Event was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy

    redirect_to :root, notice: 'Event was successfully destroyed.'
  end

  def attend
    @event.attendees << current_user

    redirect_to event_path(@event.id), notice: 'Successfully subscribed to event.'
  end

  def absent
    @event.attendees.delete current_user

    redirect_to event_path(@event.id), notice: 'Successfully unsubscribed to event.'
  end

  private

  # Redirects user in case it has not authorization to proceed
  def authorize_user
    redirect_to event_path(@event.id), alert: 'You are not allowed to do this.' unless @event.creator == current_user
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:title, :description, :date, :location, :price)
  end
end
