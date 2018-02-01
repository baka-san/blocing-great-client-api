# require 'rubygems'
require 'httparty' 
require './lib/blocing_great_client/roadmap'

class BlocingGreatClient
  include HTTParty
  include Roadmap
  base_uri 'https://www.bloc.io/api/v1'

  # Log in a user, initializing an auth token
  def initialize(email, password)
    response = self.class.post('/sessions', { query: { email: email, password: password } })
    auth_token = response['auth_token']
    headers = {
      content_type: 'application/json',
      authorization: auth_token
    }
    @options = { headers: headers }
  end

  # Retrieve current user
  def get_me
    response = self.class.get('/users/me', @options)
    @current_user = JSON.parse(response.body)
  end

  # Retrieve mentor availability
  # Ex: 946, found in get_me
  def get_mentor_availability(mentor_id = nil)
    mentor_id = mentor_id || self.get_me['current_enrollment']['mentor_id']
    response = self.class.get("/mentors/#{mentor_id}/student_availability", @options)
    response_json = JSON.parse(response.body)
  end
end

# self.class.post?

# auth = { email: email, password: password }
# options = { basic_auth: auth }
# response = self.class.get('/sessions', options)


# student_id = self.get_me[:id] or .id




