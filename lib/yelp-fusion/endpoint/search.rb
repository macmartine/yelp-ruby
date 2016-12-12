require 'json'

require 'yelp-fusion/responses/search'

module YelpFusion
  module Endpoint
    class Search
      PATH = '/v3/businesses/search'

      def initialize(client)
        @client = client
      end

      # Take a search_request and return the formatted/structured
      # response from the API
      #
      # @param location [String] a string location of the neighborhood,
      #   address, or city
      # @param params [Hash] a hash that corresponds to params on the API:
      #   http://www.yelp.com/developers/documentation/v2/search_api#searchGP
      # @param locale [Hash] a hash that corresponds to locale on the API:
      #   http://www.yelp.com/developers/documentation/v2/search_api#lParam
      # @return [Response::Search] a parsed object of the response. For a complete
      #   list of possible response values visit:
      #   http://www.yelp.com/developers/documentation/v2/search_api#rValue
      #
      # @example Search for business with params and locale
      #   params = { term: 'food',
      #              limit: 3,
      #              category: 'discgolf' }
      #
      #   locale = { lang: 'fr' }
      #
      #   response = client.search('San Francisco', params, locale)
      #   response.businesses # [<Business 1>, <Business 2>, <Business 3>]
      #   response.businesses[0].name # 'Yelp'
      #
      # @example Search with only location and params
      #   params = { term: 'food' }
      #
      #   response = client.search('San Francisco', params)
      def search(location, params = {}, locale = {})
        params.merge!(locale)
        params.merge!({location: location})

        Response::Search.new(JSON.parse(search_request(params).body))
      end

      # Search by coordinates: give it a latitude and longitude along with
      # option accuracy, altitude, and altitude_accuracy to search an area.
      # More info at: http://www.yelp.com/developers/documentation/v2/search_api#searchGC
      #
      # @param coordinates [Hash] a hash of latitude, longitude, accuracy,
      #   altitude, and altitude accuracy. Only latitude and longitude are required
      # @param params [Hash] a hash that corresponds to params on the API:
      #   http://www.yelp.com/developers/documentation/v2/search_api#searchGP
      # @param locale [Hash] a hash that corresponds to locale on the API:
      #   http://www.yelp.com/developers/documentation/v2/search_api#lParam
      # @return [Response::Search] a parsed object of the response. For a complete
      #   list of possible response values visit:
      #   http://www.yelp.com/developers/documentation/v2/search_api#rValue
      #
      # @example Search for business with params and locale
      #   coordinates = { latitude: 37.786732,
      #                   longitude: -122.399978 }
      #
      #   params = { term: 'food',
      #              limit: 3,
      #              category: 'discgolf' }
      #
      #   locale = { lang: 'fr' }
      #
      #   response = client.search(coordinates, params, locale)
      #   response.businesses # [<Business 1>, <Business 2>, <Business 3>]
      #   response.businesses[0].name # 'Yelp'
      #
      # @example Search with only location and params
      #   coordinates = { latitude: 37.786732,
      #                   longitude: -122.399978 }
      #
      #   params = { term: 'food' }
      #
      #   response = client.search(coordinates, params)
      def search_by_coordinates(coordinates, params = {}, locale = {})
        raise Error::MissingLatLng if coordinates[:latitude].nil? ||
            coordinates[:longitude].nil?

        options.merge!(coordinates)
        options.merge!(params)
        options.merge!(locale)

        Response::Search.new(JSON.parse(search_request(options).body))
      end

      private

      # Make a request against the search endpoint from the API and return the
      # raw response. After getting the response back it's checked to see if
      # there are any API errors and raises the relevant one if there is.
      #
      # @param params [Hash] a hash of parameters for the search request
      # @return [Faraday::Response] the raw response back from the connection
      def search_request(params)
        result = @client.connection.get PATH, :params => params
        Error.check_for_error(result)
        result
      end
    end
  end
end
