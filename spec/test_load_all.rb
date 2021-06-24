# run pry -r <path/to/this/file>

require_relative '../require_app'
require_app

def app
  PetsTinder::App
end

unless app.environment == :production
  require 'rack/test'
  include Rack::Test::Methods # rubocop:disable Style/MixinUsage
end