class PlaceSearch
  include ActiveModel::Model

  attr_accessor :query

  validates :query, presence: true

  def search
    google_api.text_search(@query)
  end

  def details
    google_api.details(@query)
  end

  def photo
    google_api.photo(@query)
  end

  private

  def google_api
    GoogleApi::Client.new
  end
end
