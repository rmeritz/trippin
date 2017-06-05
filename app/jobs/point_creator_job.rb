class PointCreatorJob < ApplicationJob
  def perform(args)
    point_creator = PointCreator.new args.slice("location", "trip")
    result = point_creator.save
    job_status = PointCreatorJobStatus.find(args["job_status_id"])
    job_status.done = true
    if result
      job_status.point = result
    else
      job_status.message = point_creator.errors[:location]
    end
    job_status.save!
  end
end
