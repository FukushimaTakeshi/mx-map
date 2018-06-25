class PlaceSearchController < ApplicationController
  before_action :admin_user

  def search
  end

  def index
    @place_search = PlaceSearch.new(query: params[:q]).search
  end
end
