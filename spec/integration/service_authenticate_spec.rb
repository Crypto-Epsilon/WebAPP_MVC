require_relative '../spec_helper'
require 'webmock/minitest'

describe 'Test Service Objects' do
  before do
    @credentials = { username: 'edgar.duron', password: 'mypass!' }
    @mal_credentials = { username: 'edgar.duron', password: 'wrongpassword' }
    @api_account = { username: 'edgar.duron', email: 'edgar@gmail.com' }
  end

  after do
    WebMock.reset!
  end

  describe 'Find authenticated account' do
    it 'HAPPY: should find an authenticated account' do
      auth_account_file = 'spec/fixtures/auth_account.json'
      ## Use this code to get an actual seeded account from API:
      # @credentials = { username: 'soumya.ray', password: 'mypa$$w0rd' }
      # response = HTTP.post("#{app.config.API_URL}/auth/authenticate",
      #   json: { username: @credentials[:username], password: @credentials[:password] })
      # auth_account_json = response.body.to_s
      # File.write(auth_account_file, auth_account_json)

      auth_return_json = File.read(auth_account_file)

      WebMock.stub_request(:post, "#{API_URL}/auth/authenticate")
             .with(body: SignedMessage.sign(@credentials).to_json)
             .to_return(body: auth_return_json,
                        headers: { 'content-type' => 'application/json' })

      auth = Pets_Tinder::AuthenticateAccount.new.call(**@credentials)

      account = auth[:account]['attributes']
      _(account).wont_be_nil
      _(account['username']).must_equal @api_account[:username]
      _(account['email']).must_equal @api_account[:email]
    end

    it 'BAD: Should not find a false authenticated account.' do
      WebMock.stub_request(:post, "#{API_URL}/auth/authenticate")
             .with(body: SignedMessage.sign(@mal_credentials).to_json)
             .to_return(status: 401)
      _(proc {
        Pets_Tinder::AuthenticateAccount.new.call(**@mal_credentials)
      }).must_raise Pets_Tinder::AuthenticateAccount::NotAuthenticatedError
    end
  end
end