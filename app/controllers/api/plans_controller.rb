module Api
  class PlansController < ActionController::Base
    def index
      if params[:all]
        plans = Plan.where(date: params[:date], off_road_circuit_id: params[:off_road_circuit_id]).count
      else
        plans = Plan.includes(:user).references(:user).where(
                  plans: {
                    off_road_circuit_id: params[:off_road_circuit_id], date: params[:date]
                  }
                )
        users = plans.map do |plan|
          if plan.user.present?
            { id: plan.user.id, username: plan.user.username, avatar: plan.user.avatar }
          else
            { id: nil, username: "ゲストユーザ" }
          end
        end
      end
      id = if current_user
             Plan.find_by(date: params[:date], off_road_circuit_id: params[:off_road_circuit_id], user_id: current_user.id)&.id
           else
             Plan.find_by(date: params[:date], off_road_circuit_id: params[:off_road_circuit_id], uuid: session['session_id'])&.id
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
  end
end
