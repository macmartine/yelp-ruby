require 'yelp-fusion/responses/base'
require 'yelp-fusion/responses/models/location'
require 'yelp-fusion/responses/models/review'
require 'yelp-fusion/responses/models/coordinate'
require 'yelp-fusion/responses/models/category'
require 'yelp-fusion/responses/models/hour'

module YelpFusion
  module Response
    module Model
      class Business < Response::Base
        attr_reader :id, :name, :image_url, :is_claimed, :is_closed, :url,
                    :price, :rating, :review_count, :phone, :photos, :hours,
                    :categories, :coordinates, :location

        def initialize(json)
          super(json)

          @categories  = parse(@categories, Category)
          @coordinates = parse(@coordinates, Coordinate)
          @location    = parse(@location, Location)
          @reviews     = parse(@reviews, Review)
          @hours       = parse(@hours, Hour)
        end
      end
    end
  end
end
