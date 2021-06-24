require 'http'

# Returns all projects belonging to an account
class GetPet
  def initialize(config)
    @config = config
  end

  def call(current_account, proj_id)
    response = HTTP.auth("Bearer #{current_account.auth_token}")
                   .get("#{@config.API_URL}/pets/#{pet_id}")

    response.code == 200 ? JSON.parse(response.body.to_s)['data'] : nil
  end
end