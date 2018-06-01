module GoogleApi
  class Client
    def initialize
      @conn = Faraday.new(url: Settings.apis.google.base_url) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end
    end

    def text_search(query)
      params = { query: query }.merge(api_key)
      response = http_get(Settings.apis.google.place.text_search, params)
      parse_response(response).map do |result|
        [result['name'], result['place_id']]
      end
    end

    def details(place_id)
      params = { placeid: place_id }.merge(api_key)
      response = http_get(Settings.apis.google.place.details, params)
      parse_response(response).map do |result|
        result['photos']['photo_reference']
      end
    end

    private

    def api_key
      { key: ENV['PLACES_API_KEY'] }
    end

    def http_get(url, params = {})
      @conn.get(url, params)
    end

    def parse_response(response)
      if response.success?
        JSON.parse(response.body)['results']
      else
        raise 'api_error'
      end
    end
  end
end
