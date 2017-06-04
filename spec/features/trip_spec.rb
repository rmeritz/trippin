require 'rails_helper'

RSpec.feature "trip planning", :js do
  scenario "creating a trip" do
    visit new_trip_path
    fill_in I18n.t("helpers.label.trip.title"), with: "Florida"
    click_on I18n.t("helpers.submit.trip.create")
    expect(page).to have_text "Florida"
    expect(page).to have_a_map_with_a_points
  end

  scenario "adding a starting point to a trip" do
    Geocoder::Lookup::Test.add_stub(
      "Orlando",
      [
        {
        address: "Orland, FL, USA",
        latitude: 28,
        longitude: -81
    }])

    trip = FactoryGirl.create :trip
    visit trip_path trip
    fill_in I18n.t("helpers.label.point_creator.location"), with: "Orlando"
    click_on I18n.t("helpers.submit.point_creator.create")
    expect(page).to have_a_map_with_a_points([-81, 28])
  end

  scenario "add a couple points to a trip" do
    trip = FactoryGirl.create :trip
    _idaho = FactoryGirl.create(
      :point, trip: trip, lat: 44, long: -114
    )
    _utah = FactoryGirl.create(
      :point, trip: trip, lat: 39, long: -111
    )
    visit trip_path trip
    expect(page).to have_a_map_with_a_points([-114, 44], [-111, 39])
  end

  private

  RSpec::Matchers.define :have_a_map_with_a_points do |*coordinates|
    match do |page|
      map_present? && features_at_coordinates?(coordinates)
    end
    failure_message do
      if !@map_presence
        "The map canvas was missing."
      else
        "Expected #{coordinates} Actual #{@actual_coordinates}"
      end
    end

    def map_present?
      @map_presence = find("#map").has_selector?("canvas")
    end

    def features_at_coordinates?(coordinates)
      @actual_coordinates = actual_coordinates.map do |coords|
        coords.map {|coord| coord.round }
      end
      Set.new(coordinates) == Set.new(@actual_coordinates)
    end

    def actual_coordinates
      page.driver.evaluate_script(
         "map.getLayers().item(1).getSource().getFeatures().map(function(feature) {return ol.proj.toLonLat(feature.getGeometry().getCoordinates())})"
      )
    end
  end
end
