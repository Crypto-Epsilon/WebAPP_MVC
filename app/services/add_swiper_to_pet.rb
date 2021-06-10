class AddSwiperToPet
    class OwnerNotSwiperError < StandardError
    
    def initialize(config)
            @config = config
    end

    def api_url
        @config.API_URL
    end

    def call(email:, pet_id:)
        response = HTTP.auth("Bearer #{account.auth_token}")
                       .put("#{api_url}/pets/#{pet_id}/collaborators", #please check this address
                            json: { email: swiper[:email] })
    
        raise OwnerNotSwiperError unless response.code == 200
      end
    end