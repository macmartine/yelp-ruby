require 'yelp-fusion/responses/base'
require 'yelp-fusion/responses/models/open'

module YelpFusion
  module Response
    module Model
      class Hour < Response::Base
        attr_reader :hours_type, :open, :is_open_now

        def initialize(json)
          super(json)

          @open = parse(@open, Open)
        end
      end
    end
  end
end
