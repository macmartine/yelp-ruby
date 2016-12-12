require 'yelp-fusion/responses/base'

module YelpFusion
  module Response
    module Model
      class Review < Base
        attr_reader :text, :rating, :user, :time_created, :url
      end
    end
  end
end
