require 'http'

# Create a new configuration file for a project
class CreateNewPet
  def initialize(config)
    @config = config
  end

  def api_url
    @config.API_URL
  end

  def call(current_account:, pet_data:)
    config_url = "#{api_url}/pets"
    response = HTTP.auth("Bearer #{current_account.auth_token}")
                   .post(config_url, json: pet_data)

    response.code == 201 ? JSON.parse(response.body.to_s) : raise
  end
end