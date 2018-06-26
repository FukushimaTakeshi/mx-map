class RegionsController < ApplicationController
  def index
    @prefectures = Prefecture.all
    @regions = Region.all
    @prefectures_count = OffRoadCircuit.joins(:prefecture).group("prefectures.name").count
  end
end
