require 'httparty'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    options = { body: { email: email, password: password } }
    post_response = self.class.post('/sessions', options)
    @auth_token = post_response['auth_token']

    if @auth_token.nil?
      puts "Invalid Email or Password. Please try Again."
    end
    # create an instance variable called @auth_token
    # parse response.body with JSON.parse => ruby Hash
    # hash will contain an auth token
    #JSON.parse(response.body)['auth_token']
  end

end

# HTTParty.post('path', options)
