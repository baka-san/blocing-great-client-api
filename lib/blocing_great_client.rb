# require 'rubygems'
require 'httparty' 

class BlocingGreatClient
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  # Log in a user, initializing an auth token
  def initialize(email, password)
    auth = { email: email, password: password }
    headers = {
      content_type: 'application/json'
    }
    options = { query: auth, headers: headers }
    response = self.class.post('/sessions', options)

    @auth_token = response['auth_token']
    # puts response
  end

  # Retrieve current user
  def get_me
    headers = {
      content_type: 'application/json',
      authorization: @auth_token
    }
    options = {headers: headers}
    response = self.class.get('/users/me', options)
    response_json = JSON.parse(response.body)
  end

end

# self.class.post?
# auth = { email: email, password: password }
# options = { basic_auth: auth }
# response = self.class.get('/sessions', options)
