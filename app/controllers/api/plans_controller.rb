module Api
  class PlansController < ActionController::Base
    def index
      if params[:all]
        plans = Plan.search_circuit_id(params[:off_road_circuit_id]).search_date(params[:date]).search_user_id(params[:user_id]).count
      else
        plans = Plan.with_user.search_circuit_id(params[:off_road_circuit_id]).search_date(params[:date]).search_user_id(params[:user_id])
        users = user_list(plans)
      end
      id = if current_user
             Plan.search_circuit_id(params[:off_road_circuit_id]).search_date(params[:date]).find_by(user_id: current_user.id)&.id
           else
             Plan.search_circuit_id(params[:off_road_circuit_id]).search_date(params[:date]).find_by(uuid: session['session_id'])&.id
           end

      render json: {
        plans: plans,
        users: users,
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

    def user_list(plans)
      plans.map do |plan|
        if plan.user.present?
          { id: plan.user.id, username: plan.user.username, avatar: plan.user.avatar&.url }
        else
          { id: nil, username: "ゲストユーザ" }
        end
      end
    end
  end
end
