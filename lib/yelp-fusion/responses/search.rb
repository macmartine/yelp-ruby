require 'yelp-fusion/responses/base'
require 'yelp-fusion/responses/models/business'

module YelpFusion
  module Response
    class Search < Base
      attr_reader :businesses, :region, :total

      def initialize(json)
        super(json)

        @businesses = parse(@businesses, Model::Business)
      end
    end
  end
end
