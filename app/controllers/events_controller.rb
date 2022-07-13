class EventsController < ApplicationController
  before_action :set_event, only: %i[show]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @events = Event.all.includes([:creator])
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
