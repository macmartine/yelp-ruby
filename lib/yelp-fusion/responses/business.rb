require 'yelp-fusion/responses/base'
require 'yelp-fusion/responses/models/business'

module YelpFusion
  module Response
    class Business < Base
      attr_reader :business

      def initialize(json)
        @business = parse(json, Model::Business)
      end
    end
  end
end
