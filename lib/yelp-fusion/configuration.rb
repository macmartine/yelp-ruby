require 'oauth2'

module YelpFusion
  class Configuration
    AUTH_KEYS = [:client_id, :client_secret]

    attr_accessor *AUTH_KEYS
    attr_reader :token

    # Creates the configuration
    # @param [Hash] hash containing configuration parameters and their values
    # @return [Configuration] a new configuration with the values from the
    #   config_hash set
    def initialize(config_hash = nil)
      if config_hash.is_a?(Hash)
        config_hash.each do |config_name, config_value|
          self.send("#{config_name}=", config_value)
        end

        oauth2_client = OAuth2::Client.new(@client_id, @client_secret, :site => YelpFusion::Client::API_HOST, :token_url => "/oauth2/token", :raise_errors => false)
        @token = oauth2_client.auth_code.get_token(nil)
      end
    end

    # Returns a hash of api keys and their values
    def auth_keys
      AUTH_KEYS.inject({}) do |keys_hash, key|
        keys_hash[key] = send(key)
        keys_hash
      end
    end

    def valid?
      AUTH_KEYS.none?{ |key| send(key).nil? || send(key).empty? }
    end
  end
end
