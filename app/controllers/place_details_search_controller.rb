class PlaceDetailsSearchController < ApplicationController
  def show
    @place_search = PlaceSearch.new(query: params[:place_id]).details
  end

  def new
    @place_search = PlaceSearch.new(query: params[:place_id]).details

    prefecture_name = @place_search['result']['address_components'].each do |address|
      break address['long_name'] if address['types'][0] == 'administrative_area_level_1'
    end
    prefecture = Prefecture.find_by(name: prefecture_name)

    @off_road_circuit = OffRoadCircuit.new(
      name: @place_search['result']['name'],
      address: @place_search['result']['vicinity'],
      place_id: params[:place_id],
      prefecture_id: prefecture.id,
      region_id: prefecture.region_id
    )
  end

  def create
    OffRoadCircuit.create(off_road_circuit_params)
  end

  private

  def off_road_circuit_params
    params.require(:off_road_circuit).permit(
      :name,
      :address,
      :place_id,
      :prefecture_id,
      :region_id
    )
  end
end
