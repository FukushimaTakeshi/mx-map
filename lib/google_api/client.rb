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
      parse_response(response)['results'].map do |result|
        [result['name'], result['place_id']]
      end
    end

    def details(place_id)
      params = { placeid: place_id, language: 'ja' }.merge(api_key)
      response = http_get(Settings.apis.google.place.details, params)
      parse_response(response)
    end

    def photo(photo_reference)
      params = { photoreference: photo_reference, maxheight: 500 }.merge(api_key)
      response = http_get(Settings.apis.google.place.photo, params)
      response.headers[:location]
    end

    private

    def api_key
      { key: Rails.application.credentials.apis[:google_places][:key] }
    end

    def http_get(url, params = {})
      @conn.get(url, params)
    end

    def parse_response(response)
      case response.status
      when 200..299, 400..499
        JSON.parse(response.body)
      when 300..399
        response.headers
      when 500..599
        raise
      else
        raise 'api_error'
      end
    end
  end
end
