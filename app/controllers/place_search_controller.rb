class PlaceSearchController < ApplicationController
  def search
    @place_search = PlaceSearch.new
  end

  def index
    @place_search = PlaceSearch.new(query: params[:q]).search
  end

  private

  def place_search_params
    params.require(:place_search).permit([:query])
  end
end
