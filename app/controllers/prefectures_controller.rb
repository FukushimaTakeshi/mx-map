class PrefecturesController < ApplicationController
  def show
    @prefecture = Prefecture.find(params[:id])
    @off_road_circuits = OffRoadCircuit.includes(:photo).where(prefecture_id: params[:id])
    @details = {}
    @off_road_circuits.each do |circuit|
      circuit_details(circuit.place_id.to_sym)
    end
    @favorite_courses = current_user.favorite_courses if user_signed_in?
  end

  private

  def cached_details(place_id)
    Rails.cache.fetch(place_id, expired_in: 10.days) do
      PlaceSearch.new(query: place_id).details
    end
  end

  def circuit_details(place_id)
    details = cached_details(place_id)

    @details[place_id] = {
      rating: details.dig('result', 'rating'),
      vicinity: details.dig('result', 'vicinity')
     }
  end
end
