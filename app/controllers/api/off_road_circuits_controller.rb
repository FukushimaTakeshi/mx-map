class Api::OffRoadCircuitsController < ApplicationController
  def index
    off_road_circuits = OffRoadCircuit.where(prefecture_id: params[:prefecture_id])

    render json: {
      off_road_circuits: off_road_circuits.map do |circuit|
        {
          id: circuit.id,
          name: circuit.name,
          photo_url: circuit.photo[0]&.url
        }
      end
    }
  end
end
