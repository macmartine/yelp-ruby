require 'yelp-fusion/responses/base'

module YelpFusion
  module Response
    module Model
      class User < Response::Base
        attr_reader :image_url, :name
      end
    end
  end
end
