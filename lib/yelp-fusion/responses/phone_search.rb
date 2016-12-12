require 'yelp-fusion/responses/base'
require 'yelp-fusion/responses/models/business'

module YelpFusion
  module Response
    class PhoneSearch < Base
      attr_reader :businesses, :total

      def initialize(json)
        super(json)

        @businesses = parse(@businesses, Model::Business)
      end
    end
  end
end
