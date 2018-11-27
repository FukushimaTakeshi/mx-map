class RegionsController < ApplicationController
  def index
    @regions = Region.includes(:prefectures).all
    @prefectures_count = OffRoadCircuit.joins(:prefecture).group("prefectures.name").count
  end
end
