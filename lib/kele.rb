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
    JSON.parse(response.body)
  end

  def get_messages(page = nil)
    if page != nil
      response = self.class.get("/message_threads?page=#{page}", headers: { "authorization" => @auth_token })
      JSON.parse(response.body)
    else
      response = self.class.get("/message_threads",  headers: { "authorization" => @auth_token })
      JSON.parse(response.body)
    end
  end

  def create_message(sender_email, recipient_id, stripped_text, token = nil, subject = nil)
    post_response = self.class.post("/messages", headers: { "authorization" => @auth_token }, body: { sender: sender_email, recipient_id: recipient_id, token: token, subject: subject, stripped_text: stripped_text })

    if post_response.success?
      puts "Message successfully sent."
    end
  end
end
