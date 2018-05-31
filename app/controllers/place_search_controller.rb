class PlaceSearchController < ApplicationController
  def new
    @place_search = PlaceSearch.new
  end

  def create
    @place_search = PlaceSearch.new(place_search_params)
    if @place_search.valid?
      @place_search = @place_search.search
    else
      render :new
    end
  end

  private

  def place_search_params
    params.require(:place_search).permit([:query])
  end
end
