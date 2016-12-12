require 'yelp-fusion/responses/base'

module YelpFusion
  module Response
    module Model
      class Category < Response::Base
        attr_reader :alias, :title
      end
    end
  end
end
