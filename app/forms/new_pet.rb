require_relative 'form_base'

module Pets_Tinder
  module Form
    class NewPet < Dry::Validation::Contract
      config.messages.load_paths << File.join(__dir__, 'errors/new_pet.yml')

      params do
        required(:petname).filled
        required(:petrace).filled
        required(:birthday).filled
      end
    end
  end
end