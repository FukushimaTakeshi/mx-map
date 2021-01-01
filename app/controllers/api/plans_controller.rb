module Api
  class PlansController < ActionController::API
    def index
      plans = Plan
                .includes(:user, :off_road_circuit)
                .search_circuit_id(params[:off_road_circuit_id])
                .search_date(params[:date])
                .search_user_id(params[:user_id])
                .sorted(params[:sort])

      id = Plan.search_circuit_id(params[:off_road_circuit_id]).search_date(params[:date]).find_by(uuid: request.session_options[:id].to_s)&.id unless user_signed_in?

      render json: {
        plans: plans.map do |plan|
          {
            id: plan.id,
            date: plan.date,
            off_road_circuit_id: plan.off_road_circuit_id,
            off_road_circuit_name: plan.off_road_circuit.name,
            user_details: user_details(plan.user)
          }
        end,
        id: id
      }
    end

    def create
      Plan.create!(plan_params.merge(uuid: request.session_options[:id], user_id: current_user&.id))
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

    def user_details(user)
      if user.present?
        { id: user.id, username: user.username, avatar: user.avatar&.url }
      else
        { id: nil, username: 'ゲストユーザ' }
      end
    end
  end
end
