require 'http'

# Returns all pets belonging to an account
class GetAllPets
  def initialize(config)
    @config = config
  end

  def call(current_account)
    response = HTTP.auth("Bearer #{current_account.auth_token}")
                   .get("#{@config.API_URL}/pets")

    response.code == 200 ? JSON.parse(response.to_s)['data'] : nil
  end
end