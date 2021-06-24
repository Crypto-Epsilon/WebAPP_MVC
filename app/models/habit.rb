require_relative 'pet'

module PetsTinder
  # Behaviors of the currently logged in account
  class Habit
    attr_reader :id, :name, :category, :description, # basic info
                :habit # full details

    def initialize(info)
      process_attributes(info['attributes'])
      process_included(info['include'])
    end

    private

    def process_attributes(attributes)
      @id             = attributes['id']
      @name           = attributes['name']
      @category       = attributes['category']
      @description    = attributes['description']
    end
  
    def process_included(included)
        @habit = Habit.new(included['habit'])
    end
  end
end