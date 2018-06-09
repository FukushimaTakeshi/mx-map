class PlansController < ActionController::Base
  def show
    plans = Plan.find(params[:id])
    render json: { plans: plans }
  end
end
