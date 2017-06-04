require 'rails_helper'

describe PointCreator do
  it "looks up a location and from it creates a point" do
    Geocoder::Lookup::Test.add_stub(
      "Brooklyn",
      [
        {
        address: "Brooklyn, NY, USA",
        latitude: 40.6781784,
        longitude: -73.9441579
    }])

    trip = FactoryGirl.create(:trip)
    point_creator = PointCreator.new(location: "Brooklyn", trip: trip)

    point = point_creator.save

    expect(point.trip).to eq(trip)
    expect(point.name).to eq("Brooklyn, NY, USA")
    expect(point.lat).to eq(40.6781784)
    expect(point.long).to eq(-73.9441579)
    expect(point).to be_persisted
  end

  it "looks up a location and doesn't find it and errors" do
    Geocoder::Lookup::Test.add_stub("asdasdasdas", [])

    trip = FactoryGirl.create(:trip)
    point_creator = PointCreator.new(location: "asdasdasdas", trip: trip)

    expect(point_creator.save).to be_falsey
    expect(point_creator.errors[:location]).not_to be_empty
  end
end
