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
    options = { headers: headers }
    response = self.class.get('/users/me', options)
    response_json = JSON.parse(response.body)
  end

  # Retrieve mentor availability
  def get_mentor_availability
    headers = {
      content_type: 'application/json',
      authorization: @auth_token
    }

    current_user = self.get_me
    student_id = current_user['id']
    mentor_id = current_user['current_enrollment']['mentor_id']

    options = { headers: headers}
    url = "/mentors/#{mentor_id}/student_availability"
    response = self.class.get(url, options)
    response_json = JSON.parse(response.body)
  end

end

# self.class.post?

# auth = { email: email, password: password }
# options = { basic_auth: auth }
# response = self.class.get('/sessions', options)


# student_id = self.get_me[:id] or .id




