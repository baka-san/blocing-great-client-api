require 'rubygems'
require 'httparty' 

class BlocingGreatClient
  include HTTParty
    # base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    # @url = 'https://www.bloc.io/api/v1'
    options = { query: { email: email, password: password} }
    response = self.class.post('https://www.bloc.io/api/v1/sessions', options)
    @auth_token = response["auth_token"]
    puts response
  end
end