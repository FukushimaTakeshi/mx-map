class PracticeRecodesController < ApplicationController

  def show
    @practice_recode = PracticeRecode.find(params[:id])
  end

  def new
    @user = current_user
    favorite_circuit_ids = current_user.favorite_courses.map(&:off_road_circuit_id)
    @off_road_circuit = OffRoadCircuit.find(favorite_circuit_ids)
    @practice_recode = PracticeRecode.new
  end

  def create
    @practice_recode = PracticeRecode.new(practice_recode_params)
    if @practice_recode.save
      redirect_to current_user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def practice_recode_params
    params.require(:practice_recode).permit(
      :practice_date,
      :off_road_circuit_id,
      :duration,
      :comment
    ).merge(user_id: current_user.id)
  end

end
