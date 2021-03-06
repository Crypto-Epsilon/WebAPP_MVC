require 'roda'
require_relative './app'

module PetsTinder
  # Web controller for Credence API
  class App < Roda
    route('habit') do |routing|
      routing.redirect '/auth/login' unless @current_account.logged_in?

      # GET /pets/[hab_id]
      routing.get(String) do |hab_id|
        hab_info = GetHabit.new(App.config)
                              .call(@current_account, hab_id)
        habit = Habit.new(hab_info)

        view :habit, locals: {
          current_account: @current_account, habit: habit
        }
      end
    end
  end
end