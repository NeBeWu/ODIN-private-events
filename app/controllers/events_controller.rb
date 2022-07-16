class EventsController < ApplicationController
  before_action :set_event, except: %i[index new create]
  before_action :authenticate_user!, only: %i[new create]
  before_action :authenticate_invitee, only: %i[show attend absent]
  before_action :authenticate_creator, only: %i[edit update destroy invite uninvite]

  def index
    @events = Event.joins(:invitations).where('invitations.invitee_id = ?', current_user&.id).or(Event.public?)
  end

  def show; end

  def new
    @new_event = current_user.created_events.build
  end

  def create
    @new_event = current_user.created_events.build(event_params)

    if @new_event.save
      @new_event.invitees << current_user if @new_event.private

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

  def invite
    @event.invitees << User.find(params[:user_id])

    redirect_to event_path(@event.id), notice: 'Successfully invited the user.'
  end

  def uninvite
    @event.invitees.delete User.find(params[:user_id])

    redirect_to event_path(@event.id), notice: 'Successfully uninvited the user.'
  end

  private

  # Redirects user in case it is not the creator
  def authenticate_creator
    redirect_to event_path(@event.id), alert: 'You are not allowed to do this.' unless @event.creator == current_user
  end

  # Redirects user in case it is not an invitee
  def authenticate_invitee
    return if !@event.private || @event.invitees.exists?(current_user&.id)

    redirect_to events_path, alert: 'You are not allowed to do this.'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:title, :description, :date, :location, :price, :private)
  end
end
