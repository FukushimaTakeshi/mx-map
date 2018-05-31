class PlaceSearch
  include ActiveModel::Model

  attr_accessor :query

  validates :query, presence: true

  def search
    res = Faraday.get 'https://maps.googleapis.com/maps/api/place/textsearch/json', { key: ENV['PLACES_API_KEY'], query: @query }

    if res.success?
      JSON.parse(res.body)['results'].map do |result|
        [result['name'], result['place_id']]
      end
    else
      'NOT FOUND'
    end
  end
end
