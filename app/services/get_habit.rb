require 'http'

# Returns all projects belonging to an account
class GetHabit
  def initialize(config)
    @config = config
  end

  def call(user, hab_id)
    response = HTTP.auth("Bearer #{user.auth_token}")
                   .get("#{@config.API_URL}/habits/#{hab_id}")

    response.code == 200 ? JSON.parse(response.body.to_s)['data'] : nil
  end
end