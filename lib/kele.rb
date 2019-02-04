require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
  include HTTParty
  include Roadmap

  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    options = { body: { email: email, password: password } }
    post_response = self.class.post('/sessions', options)
    @auth_token = post_response['auth_token']

    if @auth_token.nil?
      puts "Invalid Email or Password. Please try Again."
    end
  end

  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    item = JSON.parse(response.body)
    item.to_a
  end
end
