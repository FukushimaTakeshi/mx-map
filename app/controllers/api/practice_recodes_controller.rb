class Api::PracticeRecodesController < ActionController::API
  before_action :authenticate_user!

  def index
    render json: PracticeRecode.where(user_id: current_user.id)
  end

  def show
    render json: PracticeRecode.find(params[:id])
  end

  def create
    practice_recode = PracticeRecode.new(practice_recode_params)
    if practice_recode.save
      head :created
    else
      render json: practice_recode.errors.as_json
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
end
