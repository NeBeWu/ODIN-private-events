class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  before_action :authenticate_user!, except: %i[index show]

  def show
    @created_events = @user.created_events
  end

  def edit; end

  def update
    @user.assign_attributes(user_params)

    if @user.save
      redirect_to user_path(current_user.id), notice: 'Event was successfully created.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :description, :website)
  end
end
