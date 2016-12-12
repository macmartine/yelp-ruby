require 'yelp-fusion/version'
require 'yelp-fusion/client'

module YelpFusion
  # Returns an initially-unconfigured instance of the client.
  # @return [Client] an instance of the client
  #
  # @example Configuring and using the client
  #   YelpFusion.client.configure do |config|
  #     config.client_id = 'abc'
  #     config.client_secret = 'def'
  #   end
  #
  #   YelpFusion.client.search('San Francisco', { term: 'food' })
  #
  def self.client
    @client ||= YelpFusion::Client.new
  end
end
