require_relative 'pet'

module Pets_Tinder
  # Behaviors of the currently logged in account
  class Pet
    attr_reader :id, :petname, :petrace, :birthday, :description

    def initialize(pet_info)
      @id = pet_info['attributes']['id']
      @petname = pet_info['attributes']['petname']
      @petrace = pet_info['attributes']['petrace']
      @birthday = pet_info['attributes']['birthday']
      @description = pet_info['attributes']['description']
    end
  end
end