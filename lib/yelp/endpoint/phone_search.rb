require 'json'

module Yelp
  module Endpoint
    class PhoneSearch
      PATH = '/v2/phone_search'

      def initialize(client)
        @client = client
      end

      # Make a request to the phone search endpoint on the API
      #
      # @param phone [String] the phone number
      # @param params [Hash] a hash that corresponds to params on the API:
      #   https://www.yelp.com/developers/documentation/v2/phone_search
      # @return [BurstStruct] the parsed response object from the API
      #
      # @example Search for business by phone number with params
      #   params = { cc: 'US',
      #              category: 'discgolf' }
      #   response = client.phone_search('5555555555')
      #   response.businesses # [<Business 1>, <Business 2>, <Business 3>]
      #   response.businesses[0].name # 'Yelp'
      def phone_search(phone, params = {})
        params.merge!({phone: phone, cc: "US"})
        BurstStruct::Burst.new(JSON.parse(phone_search_request(params).body))
      end

      private

      # Make a request against the search endpoint from the API and return the
      # raw response. After getting the response back it's checked to see if
      # there are any API errors and raises the relevant one if there is.
      #
      # @param params [Hash] a hash of parameters for the search request
      # @return [Faraday::Response] the raw response back from the connection
      def phone_search_request(params)
        result = @client.connection.get PATH, params
        Error.check_for_error(result)
        result
      end
    end
  end
end
