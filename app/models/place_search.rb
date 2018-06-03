class PlaceSearch
  include ActiveModel::Model

  attr_accessor :query

  validates :query, presence: true

  def search
    google_api_client = GoogleApi::Client.new
    google_api_client.text_search(@query)
  end

  def details
    google_api_client = GoogleApi::Client.new
    google_api_client.details(@query)
  end
end
