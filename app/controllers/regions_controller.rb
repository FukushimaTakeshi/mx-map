class RegionsController < ApplicationController
  def index
    @prefectures = Prefecture.all
    @regions = Region.all
  end

  def show
    @prefecture = Prefecture.find(params[:id])
  end
end
