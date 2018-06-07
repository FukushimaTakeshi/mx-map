class RegionsController < ApplicationController
  def index
    @prefectures = Prefecture.all
    @regions = Region.all
    @prefectures_count = OffRoadCircuit.joins(:prefecture).group("prefectures.name").count
  end

  def show
    @prefecture = Prefecture.find(params[:id])
  end
end
