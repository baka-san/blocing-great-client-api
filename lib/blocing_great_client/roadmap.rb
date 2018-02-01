module Roadmap
  # Retrieve the roadmap
  # Ex: 37, found in get_me for current
  def get_roadmap(roadmap_id)
    # roadmap_id = roadmap_id || self.get_me['current_enrollment']['roadmap_id']
    response = self.class.get("/roadmaps/#{roadmap_id}", @options)
    response_json = JSON.parse(response.body)
  end


  # Retrieve a checkpoint
  # Ex: >2300, found in get_roadmap
  def get_checkpoint(checkpoint_id)
    response = self.class.get("/checkpoints/#{checkpoint_id}", @options)
    response_json = JSON.parse(response.body)
  end
end