class PlaceDetailsSearchController < ApplicationController
  def show
    @place_search = PlaceSearch.new(query: params[:place_id]).details
  end
end
