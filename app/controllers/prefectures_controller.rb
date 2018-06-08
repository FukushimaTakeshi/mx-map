class PrefecturesController < ApplicationController
  def index
    @prefecture = Prefecture.find(params[:region_id])
    @off_road_circuits = OffRoadCircuit.where(prefecture_id: params[:region_id])
    @details = {}
    @off_road_circuits.each do |circuit|
      circuit_details(circuit.place_id.to_sym)
    end
  end

  def show
  end

  private

  def cached_details(place_id)
    Rails.cache.fetch(place_id, expired_in: 10.days) do
      PlaceSearch.new(query: place_id).details
    end
  end

  def circuit_details(place_id)
    details = cached_details(place_id)

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
