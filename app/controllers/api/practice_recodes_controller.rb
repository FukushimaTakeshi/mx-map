class Api::PracticeRecodesController < ActionController::API
  before_action :authenticate_user!

  def index
    practice_recodes = PracticeRecode
                         .includes(off_road_circuit: [:photo])
                         .where(user_id: current_user.id)
                         .search_date(params[:date])
                         .sorted(params[:sort])

    render json: {
      practice_recodes: practice_recodes.map do |practice_recode|
        {
          id: practice_recode.id,
          practice_date: practice_recode.practice_date,
          duration: practice_recode.duration,
          comment: practice_recode.comment,
          off_road_circuit_id: practice_recode.off_road_circuit_id,
          off_road_circuit_name: practice_recode.off_road_circuit.name,
          photo_url: practice_recode.off_road_circuit.photo[0]&.url
        }
      end
    }
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
