class PlaceSearchController < ApplicationController
  def search
    @place_search = PlaceSearch.new
  end

  def index
    @place_search = PlaceSearch.new(query: params[:q]).search
  end
end
