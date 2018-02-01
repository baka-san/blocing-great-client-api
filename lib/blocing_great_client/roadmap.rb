module Roadmap
  # Retrieve the roadmap
  # Ex: 37, found in get_me for current
  def get_roadmap(roadmap_id = @current_user["current_enrollment"]["roadmap_id"])
    response = self.class.get("/roadmaps/#{roadmap_id}", @options)
    @roadmap = JSON.parse(response.body)
    puts JSON.pretty_generate(@roadmap, { indent: "  " })
  end


  # Retrieve a checkpoint
  # Ex: >2300, found in get_roadmap
  def get_checkpoint(checkpoint_id)
    response = self.class.get("/checkpoints/#{checkpoint_id}", @options)
    @checkpoint = JSON.parse(response.body)
    puts JSON.pretty_generate(@checkpoint, { indent: "  " })
  end
end