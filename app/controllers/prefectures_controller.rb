class PrefecturesController < ApplicationController
  def index
    @off_road_circuit = OffRoadCircuit.where(prefecture_id: params[:region_id])
  end
end
