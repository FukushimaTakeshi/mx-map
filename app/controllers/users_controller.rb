class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :avatar,
      mx_profile_attributes: [:id, :mx_history_id, :license_id]
    )
  end

  def correct_user
    redirect_to user_path(current_user) unless current_user.id.to_s == params[:id]
  end
end
