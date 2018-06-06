class PrefecturesController < ApplicationController
  def index
    @off_road_circuits = OffRoadCircuit.where(prefecture_id: params[:region_id])
    @details = {}
    @off_road_circuits.each do |circuit|
      circuit_details(circuit.place_id.to_sym)
    end
  end

  def show
  end

  private

  def circuit_details(place_id)
    details = JSON.parse(Rails.cache.read(place_id))

    photo_array = details['result']['photos'].map do |photo|
      photo['photo_reference']
    end

    @details[place_id] = {
      photos: photo_array,
      rating: details['result']['rating'],
      vicinity: details['result']['vicinity']
     }
  end
end
