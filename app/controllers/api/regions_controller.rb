class Api::RegionsController < ApplicationController
  def index
    render json: Region.select_list
  end
end
