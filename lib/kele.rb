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
  end

end
