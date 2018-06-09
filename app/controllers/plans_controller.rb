class PlansController < ActionController::Base
  def show
    plans = Plan.all
    render json: { plans: plans }
  end
end
