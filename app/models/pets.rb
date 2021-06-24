require_relative 'pet'

module PetsTinder
  # Behaviors of the currently logged in account
  class Pet
    attr_reader :all

    def initialize(pet_list)
      @all = pet_list.map do |pe|
        Pet.new(pe)
      end
    end
  end
end