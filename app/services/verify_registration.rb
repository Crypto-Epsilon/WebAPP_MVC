require 'http'

module PetsTinder
  # Returns an authenticated user, or nil
  class VerifyRegistration
    class VerificationError < StandardError; end

    def initialize(config)
      @config = config
    end

    def call(registration_data)
      registration_token = SecureMessage.encrypt(registration_data)
      registration_data['verification_url'] =
        "#{@config.APP_URL}/auth/register/#{registration_token}"

      response = HTTP.post(
        "#{@config.API_URL}/auth/register",
        json: SignedMessage.sign(registration_data)
      )

      raise(VerificationError) unless response.code == 202

      JSON.parse(response.to_s)
    end
  end
end