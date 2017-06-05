class PointCreatorJobStatusesController < ApplicationController
  def show
    job_status = PointCreatorJobStatus.find(params[:id])
    if !job_status.done?
      head :ok
    elsif job_status.point.present?
      render json: job_status.point, status: :created
    else
      render json: job_status.message, status: 422
    end
  end
end
