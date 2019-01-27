module Api
  class PlansController < ActionController::API
    def index
      if params[:all]
        plans = Plan.includes(:off_road_circuit).search_circuit_id(params[:off_road_circuit_id]).search_date(params[:date]).search_user_id(params[:user_id])
      else
        plans = Plan.with_user.includes(:off_road_circuit).search_circuit_id(params[:off_road_circuit_id]).search_date(params[:date]).search_user_id(params[:user_id]).order('plans.date')
        users = user_list(plans)
        off_road_circuits = off_road_circuit_list(plans)
      end
      id = if current_user
             Plan.search_circuit_id(params[:off_road_circuit_id]).search_date(params[:date]).find_by(user_id: current_user.id)&.id
           else
             Plan.search_circuit_id(params[:off_road_circuit_id]).search_date(params[:date]).find_by(uuid: session['session_id'])&.id
           end
      render json: {
        plans: plans.map do |plan|
          {
            id: plan.id,
            date: plan.date,
            off_road_circuit_id: plan.off_road_circuit_id,
            off_road_circuit_name: plan.off_road_circuit.name
          }
        end,
        users: users,
        off_road_circuits: off_road_circuits,
        id: id
      }
    end

    def create
      Plan.create!(plan_params.merge(uuid: session['session_id'], user_id: current_user&.id))
      head :created
    end

    def destroy
      Plan.find(params[:id]).destroy!
      head :ok
    end

    private

    def plan_params
      params.require(:plan).permit(
        :date,
        :off_road_circuit_id
      )
    end

    def user_list(plans)
      plans.map do |plan|
        if plan.user.present?
          { id: plan.user.id, username: plan.user.username, avatar: plan.user.avatar&.url }
        else
          { id: nil, username: "ゲストユーザ" }
        end
      end
    end

    def off_road_circuit_list(plans)
      circuits = plans.map do |plan|
        { id: plan.off_road_circuit.id, name: plan.off_road_circuit.name }
      end
      circuits.group_by do |circuit|
        circuit[:id]
      end.values
    end
  end
end
