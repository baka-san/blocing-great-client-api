require "httparty" 
require "./lib/blocing_great_client/roadmap"

class BlocingGreatClient
  include HTTParty
  include Roadmap
  base_uri "https://www.bloc.io/api/v1"

  # Log in a user, initializing an auth token
  def initialize(email, password)
    response = self.class.post("/sessions", { query: { email: email, password: password } })
    auth_token = response["auth_token"]
    headers = {
      content_type: "application/json",
      authorization: auth_token
    }
    @options = { headers: headers}
    get_me
  end

  # Retrieve current user
  def get_me
    response = self.class.get("/users/me", @options)
    @current_user = JSON.parse(response.body)
    puts JSON.pretty_generate(@current_user, { indent: "  " })
  end

  # Retrieve mentor availability
  # Ex: 946, found in get_me
  def get_mentor_availability(mentor_id = @current_user["current_enrollment"]["mentor_id"])
    response = self.class.get("/mentors/#{mentor_id}/student_availability", @options)
    @mentor_availability = JSON.parse(response.body)
    puts JSON.pretty_generate(@mentor_availability, { indent: "  " })
  end

  # Check messages with your mentor
  def get_messages(page = 1)
    options = @options
    options[:query] = { page: page }
    response = self.class.get("/message_threads", options)
    @messages = JSON.parse(response.body)
    puts JSON.pretty_generate(@messages, { indent: "  " })
  end

  # Create new message to your mentor
  # To reply to an old message, input token found via bloc.get_messages["items"][#]["token"]
  # For a new chat thread, leave chat_token blank
  def create_message(message_body, message_subject = nil, chat_token = nil)
    sender_email = @current_user["email"]
    recipient_id = @current_user["current_enrollment"]["mentor_id"]
    body = {
      sender: sender_email, 
      recipient_id: recipient_id,
      token: chat_token,
      subject: message_subject,
      'stripped-text': message_body
    }

    options = @options
    options[:body] = body
    response = self.class.post("/messages", options)
    @new_message = JSON.parse(response.body)
    puts JSON.pretty_generate(@new_message, { indent: "  " })
  end

end

# self.class.post?

# auth = { email: email, password: password }
# options = { basic_auth: auth }
# response = self.class.get("/sessions", options)


# student_id = self.get_me[:id] or .id

# bloc.create_message(message_body="# Wow, this is a blocing great message!", message_subject="Test message via Blocing Great Client", )




