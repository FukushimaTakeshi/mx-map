class OffRoadCircuitsController < ApplicationController
  before_action :admin_user, except: [:show]

  def show
    @off_road_circuit = OffRoadCircuit.find(params[:id])
    @detail = circuit_details(@off_road_circuit.place_id.to_sym)
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
    @off_road_circuit = OffRoadCircuit.new(off_road_circuit_params)
    if @off_road_circuit.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @off_road_circuit = OffRoadCircuit.find(params[:id])
  end

  def update
    @off_road_circuit = OffRoadCircuit.find(params[:id])

    if @off_road_circuit.update(off_road_circuit_params)
      redirect_to @off_road_circuit
    else
      render 'edit'
    end
  end

  def destroy
    OffRoadCircuit.find(params[:id]).destroy
  end

  private

  def off_road_circuit_params
    params.require(:off_road_circuit).permit(
      :name,
      :address,
      :url,
      :place_id,
      :prefecture_id,
      :region_id
    )
  end

  def circuit_details(place_id)
    details = Rails.cache.fetch(place_id, expired_in: 10.days) do
      PlaceSearch.new(query: place_id).details
    end
    {
      rating: details['result']['rating'],
      vicinity: details['result']['vicinity']
     }
  end
end
