module Api
  class OffRoadCircuitsController < ApplicationController
    def index
      off_road_circuits = OffRoadCircuit.all
      
      render json: off_road_circuits
    end
  end
end
