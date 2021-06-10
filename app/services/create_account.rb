require 'http'

module Pets_Tinder
  # Returns an authenticated user, or nil
  class CreateAccount
    class InvalidAccount < StandardError
      def message
        'This account can no longer be created: please start again'
      end
    end

    def initialize(config)
      @config = config
    end

    def call(email:, username:, password:)
      message = { email: email,
                  username: username,
                  password: password }

      response = HTTP.post(
        "#{@config.API_URL}/accounts/",
        json: message
      )

      raise InvalidAccount unless response.code == 201
    end
  end
end