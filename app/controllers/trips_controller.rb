class TripsController < ApplicationController
  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new trip_params
    @trip.save
    redirect_to @trip
  end

  def show
    @trip = Trip.find params[:id]
    @point_creator = PointCreator.new
  end

  private

  def trip_params
    params.require(:trip).permit(:title)
  end
end
