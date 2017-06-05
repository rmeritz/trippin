class PointCreatorsController < ApplicationController
  def create
    point_creator = PointCreator.new point_creator_params
    render json: point_creator.save
  end

  private
  def trip
    Trip.find params[:trip_id]
  end

  def point_creator_params
    params.require(:point_creator).permit(:location).merge(trip: trip)
  end
end
