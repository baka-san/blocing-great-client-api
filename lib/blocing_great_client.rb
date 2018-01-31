require 'httparty' 

class BlocingGreatClient
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    auth = { email: email, password: password }
    options = { basic_auth: auth }
    response = self.class.get('/sessions', options)

    @auth_token = response['auth_token']
    puts response
  end
end

# self.class.post?
# auth = { email: email, password: password }
# options = { basic_auth: auth }
# response = self.class.get('/sessions', options)
