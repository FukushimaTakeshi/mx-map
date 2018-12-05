class Api::RegionsController < ActionController::API
  def index
    render json: Region.select_list
  end
end
