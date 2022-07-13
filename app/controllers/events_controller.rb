class EventsController < ApplicationController
  def index
    @events = Event.all
  end

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

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :location, :price)
  end
end
