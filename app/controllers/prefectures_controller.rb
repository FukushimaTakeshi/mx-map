class PrefecturesController < ApplicationController
  def index
    @off_road_circuits = OffRoadCircuit.where(prefecture_id: params[:region_id])
    @photos = {}
    @reviews = {}
    @vicinity = {}
    @off_road_circuits.each do |circuit|
      circuit_details(circuit.place_id)
    end
  end

  def show
  end

  private

  def circuit_details(place_id)
    details = JSON.parse(Rails.cache.read(place_id))

    @photos[place_id] = details['result']['photos'].map do |photo|
      photo['photo_reference']
    end

    @reviews[place_id] = details['result']['rating']
    @vicinity[place_id] = details['result']['vicinity']
  end
end
