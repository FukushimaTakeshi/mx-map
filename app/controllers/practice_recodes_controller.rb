class PracticeRecodesController < ApplicationController

  def index
    @practice_recodes = PracticeRecode.where(user_id: current_user.id)
  end

  def show
    @practice_recode = PracticeRecode.find(params[:id])
  end

  def new
    @off_road_circuits = favorite_off_road_circuits
    @practice_recode = PracticeRecode.new
  end

  def create
    @practice_recode = PracticeRecode.new(practice_recode_params)
    if @practice_recode.save
      redirect_to [current_user, @practice_recode]
    else
      @off_road_circuits = favorite_off_road_circuits
      render :new
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
      :duration_hour,
      :duration_minute,
      :comment
    ).merge(user_id: current_user.id)
  end

  def favorite_off_road_circuits
    favorite_circuit_ids = current_user.favorite_courses.map(&:off_road_circuit_id)
    OffRoadCircuit.find(favorite_circuit_ids)
  end

end
