require_relative 'form_base'

module PetsTinder
  module Form
    class NewHabit < Dry::Validation::Contract
      config.messages.load_paths << File.join(__dir__, 'errors/new_habit.yml')

      params do
        required(:name).filled(max_size?: 256, format?: NAME_REGEX)
        required(:category).maybe(max_size?: 256, format?: NAME_REGEX)
        required(:description).maybe(:string)
      end
    end
  end
end