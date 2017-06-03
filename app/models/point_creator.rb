class PointCreator
  include ActiveModel::Model

  attr_accessor :location, :trip

  def save
    geocoder_result = Geocoder.search(location).first
    if geocoder_result
      create_point(geocoder_result)
    else
      errors.add(:location, :does_not_exist)
      false
    end
  end

  private

  def create_point(geocoder_result)
    Point.create!(
      name: geocoder_result.address,
      lat: geocoder_result.latitude,
      long: geocoder_result.longitude,
      trip: trip
    )
  end
end
