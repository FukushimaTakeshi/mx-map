class PlansController < ActionController::Base
  def index
    plans = Plan.where(off_road_circuit_id: params[:off_road_circuit_id]).count
    id = Plan.find_by(off_road_circuit_id: params[:off_road_circuit_id], uuid: session['session_id'])&.id

    render json: {
      plans: plans,
      id: id
    }
  end

  def create
    Plan.create(plan_params.merge(uuid: session['session_id']))
    head :ok
  end

  def destroy
    Plan.find(params[:id]).destroy
    head :ok
  end

  private

  def plan_params
    params.require(:plan).permit(
      :date,
      :off_road_circuit_id
    )
  end
end
