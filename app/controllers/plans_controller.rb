class PlansController < ApplicationController
  def index
    # @plans = Plan.where(
    #   off_road_circuit_id: params[:off_road_circuit_id],
    #   date: Date.current..Date.current.since(2.week)
    # )
    @plans = Plan.includes(:user)
                 .references(:user)
                 .where(plans: {
                   off_road_circuit_id: params[:off_road_circuit_id],
                   date: Date.current..Date.current.since(2.week)
                 })
                 .order('plans.date')
                 .group_by { |v| v.date }
  end
end
