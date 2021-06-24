require_relative 'pet'

module PetsTinder
  # Behaviors of the currently logged in account
  class Pet
    attr_reader :id, :petname, :petrace, :birthday, :description,
                :owner, :swipers, :habit

    def initialize(pet_info)
      process_attributes(pet_info['attributes'])
      process_relationships(pet_info['relationships'])
      process_policies(pet_info['policies'])
    end

    private

    def process_attributes(attributes)
      @id = attributes['id']
      @petname = attributes['petname']
      @petrace = attributes['petrace']
      @birthday = attributes['birthday']
    end

    def process_relationships(relationships)
      return unless relationships

      @owner = Account.new(relationships['owner'])
      @habits = process_habits(relationships['habits'])
    end

    def process_policies(policies)
      @policies = OpenStruct.new(policies)
    end

    def process_habit(swipers_info)
      return nil unless swipers_info

      swipers_info.map { |swip_info| Swipers.new(swip_info) }
    end

    def process_habits(habits)
      return nil unless habits

      habits.map { |account_info| Account.new(account_info) }
    end
  end
end