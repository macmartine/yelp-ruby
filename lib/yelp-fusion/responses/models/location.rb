require 'yelp-fusion/responses/base'

module YelpFusion
  module Response
    module Model
      class Location < Response::Base
        attr_reader :city, :country, :address1, :address2, :address3, :state, :zip_code
      end
    end
  end
end
