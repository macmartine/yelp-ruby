require 'yelp-fusion/responses/base'

module YelpFusion
  module Response
    module Model
      class Coordinate < Response::Base
        attr_reader :latitude, :longitude
      end
    end
  end
end
