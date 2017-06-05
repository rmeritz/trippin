class PointCreatorsController < ApplicationController
  def create
    job_status = PointCreatorJobStatus.create
    job = PointCreatorJob.perform_later job_args(job_status)
    job_status.update!(job: job.provider_job_id)
    render json: {job_status_id: job_status.id}, status: :created
  end

  private
  def trip
    Trip.find params[:trip_id]
  end

  def point_creator_params
    params.require(:point_creator).permit(:location).merge(trip: trip)
  end

  def job_args(job_status)
    point_creator_params.merge(job_status_id: job_status.id).to_hash
  end
end
