class PlaceSearchController < ApplicationController
  def search
  end

  def index
    @place_search = PlaceSearch.new(query: params[:q]).search
  end
end
