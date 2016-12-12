require 'yelp-fusion/responses/base'

module YelpFusion
  module Response
    module Model
      class Open < Response::Base
        attr_reader :is_overnight, :end, :day, :start
      end
    end
  end
end
