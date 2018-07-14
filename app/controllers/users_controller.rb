class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

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
      mx_profile_attributes: [:mx_history_id, :license_id, :_destroy, :id]
    )
  end

  def logged_in_user
    unless user_signed_in?
      flash[:notice] = 'ログインまたは登録が必要です。'
      redirect_to new_user_session_url
    end
  end

  def correct_user
    redirect_to root_url unless current_user.id.to_s == params[:id]
  end
end
