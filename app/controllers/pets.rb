require 'roda'
require_relative './app'

module Pets_Tinder
  # Web controller for Credence API
  class App < Roda
    route('pet') do |routing|
      routing.on do
        routing.redirect '/auth/login' unless @current_account.logged_in?
        @pet_route = '/pet'

        routing.on(String) do |pet_id|
          @pet_route = "#{@pet_route}/#{pet_id}"

          # GET /pets/[pet_id]
          routing.get do
            pet_info = GetPet.new(App.config).call(
              @current_account, pet_id
            )
            pet = Pet.new(pet_info)

            view :pet, locals: {
              current_account: @current_account, pet: pet
            }
          rescue StandardError => e
            puts "#{e.inspect}\n#{e.backtrace}"
            flash[:error] = 'Pet not found.'
            routing.redirect @pet_route
          end

          # POST /pets/[pet_id]/habit/
          routing.post('habit') do
            habit_data = Form::NewHabit.new.call(routing.params)
            if habit_data.failure?
              flash[:error] = Form.message_values(habit_data)
              routing.halt
            end

            CreateNewHabit.new(App.config).call(
              current_account: @current_account,
              pet_id: pet_id,
              habit_data: habit_data.to_h
            )

            flash[:notice] = 'Your habit was added.'
          rescue StandardError => e
            puts "Error creating habit: #{e.inspect}"
            flash[:error] = 'Could not add habit.'
          ensure
            routing.redirect @pet_route
          end
        end

        # GET /pets/
        routing.get do
          pet_list = GetAllPets.new(App.config).call(@current_account)

          pet = Pet.new(pet_list)

          view :pet_all, locals: {
            current_account: @current_account, pet: pet
          }
        end

        # POST /pets/
        routing.post do
          routing.redirect '/auth/login' unless @current_account.logged_in?
          
          pet_data = Form::NewPet.new.call(routing.params)
          if pet_data.failure?
            flash[:error] = Form.message_values(pet_data)
            routing.halt
          end

          CreateNewPet.new(App.config).call(
            current_account: @current_account,
            pet_data: pet_data.to_h
          )

          flash[:notice] = 'Add habits to your new pet.'
        rescue StandardError => e
          puts "FAILURE Creating Pet: #{e.inspect}."
          flash[:error] = 'Could not create pet.'
        ensure
          routing.redirect @pet_route
        end
      end
    end
  end
end