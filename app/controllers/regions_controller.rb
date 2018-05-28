class PrefecturesController < ApplicationController
  def index
    @prefectures = Prefecture.all
    @regions = Region.all
    # raise
  end

  def show
    @prefecture = Prefecture.find(params[:id])
  end
end
