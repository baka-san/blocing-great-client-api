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
    raise "Invalid Email or Password. Try Again." if auth_token.nil?
    headers = {
      # 'content-type': "application/json",
      authorization: auth_token
    }
    @options = { headers: headers}
    get_me()
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
    body = {
      sender: @current_user["email"], 
      recipient_id: @current_user["current_enrollment"]["mentor_id"],
      "stripped-text": message_body
    }

    body[:token] = chat_token if chat_token
    body[:subject] = message_subject if message_subject
    @options[:body] = body
    response = self.class.post("/messages", @options)
    puts "Message Sent!"
  end

  # Submit an assignment
  # checkpoint_id via @checkpoint["id"], e.g. 2162
  # assignment_branch = Name of GitHub branch e.g. checkpoint-8-checkpoint-submission
  # assignment_commit_link = GitHub commit link for the assignment e.g. https://github.com/baka-san/blocing_great_client/tree/checkpoint-8-checkpoint-submission
  def create_submission(checkpoint_id, assignment_branch = nil, assignment_commit_link = nil, comment = nil)
    body = {
        enrollment_id: @current_user["current_enrollment"]["id"],
        checkpoint_id: checkpoint_id
    }

    body[:assignment_branch] = assignment_branch if assignment_branch
    body[:assignment_commit_link] = assignment_commit_link if assignment_commit_link
    body[:comment] = comment if comment

    @options[:body] = body
    response = self.class.post("/checkpoint_submissions", @options)
    puts body
    puts "response.headers = #{response.headers}"
    puts "response.body = #{response.body}"
    puts "response.request = #{response.request}"
    puts "response.response = #{response.response}"
    puts "response = #{response}"
    puts "Checkpoint Submitted!"
  end

end

# self.class.post?

# auth = { email: email, password: password }
# options = { basic_auth: auth }
# response = self.class.get("/sessions", options)


# student_id = self.get_me[:id] or .id

# bloc.create_message("# Wow, this is a blocing great message!", "Test message via Blocing Great Client")

# bloc.create_submission(2162, "checkpoint-8-checkpoint-submission", "https://github.com/baka-san/blocing_great_client/tree/checkpoint-8-checkpoint-submission", "I sure hope this works...")

# bloc.create_submission(2161, "checkpoint-8-checkpoint-submission", "https://github.com/baka-san/blocing_great_client/tree/checkpoint-8-checkpoint-submission", "I sure hope this works...")


