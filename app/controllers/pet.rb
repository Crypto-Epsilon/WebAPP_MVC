require 'roda'

module Pets_Tinder
  # Web controller for Pets_Tinder API
  class App < Roda
    route('pet') do |routing|
      routing.on do
        # GET /pet/
        routing.get do
          if @current_account.logged_in?
            pet_list = GetAllPets.new(App.config).call(@current_account)

            pet = Pet.new(pet_list)

            view :pet_all,
                 locals: { current_user: @current_account, pet: pet }
          else
            routing.redirect '/auth/login'
          end
        end
      end
    end
  end
end