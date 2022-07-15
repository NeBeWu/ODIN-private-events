class UsersController < ApplicationController
  before_action :set_user, except: %i[index new create]
  before_action :authenticate_user!, except: %i[index show]
  before_action :authorize_user, only: %i[edit update]

  def show; end

  def edit; end

  def update
    @user.assign_attributes(user_params)

    if @user.save
      redirect_to user_path(current_user.id), notice: 'Profile was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # Redirects user in case it has not authorization to proceed
  def authorize_user
    redirect_to user_path(@user.id), alert: 'You are not allowed to do this.' unless @user == current_user
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :description, :website)
  end
end
