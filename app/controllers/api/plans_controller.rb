module Api
  class PlansController < ActionController::Base
    def index
      plans = Plan.where(date: params[:date], off_road_circuit_id: params[:off_road_circuit_id]).count
      id = if current_user
             Plan.find_by(date: params[:date], off_road_circuit_id: params[:off_road_circuit_id], user_id: current_user.id)&.id
           else
             Plan.find_by(date: params[:date], off_road_circuit_id: params[:off_road_circuit_id], uuid: session['session_id'])&.id
           end

      render json: {
        plans: plans,
        id: id
      }
    end

    def create
      Plan.create(plan_params.merge(uuid: session['session_id'], user_id: current_user&.id))
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
end
