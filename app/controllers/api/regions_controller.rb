class Api::RegionsController < ActionController::API
  def index
    render json: Region.includes(:prefectures).select_list
  end
end
