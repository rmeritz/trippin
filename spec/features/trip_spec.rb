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
        address: "Orlando, FL, USA",
        latitude: 28,
        longitude: -81
    }])

    trip = FactoryGirl.create :trip
    visit trip_path trip
    fill_in I18n.t("helpers.label.point_creator.location"), with: "Orlando"
    click_on I18n.t("helpers.submit.point_creator.create")
    expect(page).to have_a_map_with_a_points([-81, 28, "Orlando, FL, USA"])
  end

  scenario "add a couple points to a trip" do
    trip = FactoryGirl.create :trip
    FactoryGirl.create(
      :point, trip: trip, lat: 44, long: -114, name: "Idaho, USA"
    )
    FactoryGirl.create(
      :point, trip: trip, lat: 39, long: -111, name: "Utah, USA"
    )
    visit trip_path trip
    expect(page).to have_a_map_with_a_points(
      [-114, 44, "Idaho, USA"],
      [-111, 39, "Utah, USA",]
    )
  end

  private

  RSpec::Matchers.define :have_a_map_with_a_points do |*points|
    match do |page|
      map_present? && features_at_coordinates?(points, 0)
    end
    failure_message do
      if !@map_presence
        "The map canvas was missing."
      else
        "Expected #{points} Actual #{@actual_coordinates}"
      end
    end

    def map_present?
      @map_presence = find("#map").has_selector?("canvas")
    end

    def features_at_coordinates?(points, tries)
      @actual_coordinates = actual_coordinates
      if Set.new(points) == Set.new(@actual_coordinates)
        true
      elsif tries < 5
        features_at_coordinates?(points, tries + 1)
      else
        false
      end
    end

    def actual_coordinates
      page.driver.evaluate_script(
      #   "map.getLayers().item(1).getSource().getFeatures().map(function(feature) {return ol.proj.toLonLat(feature.getGeometry().getCoordinates())})"
      "map.getLayers().item(1).getSource().getFeatures().map(function(feature) {var coord = ol.proj.toLonLat(feature.getGeometry().getCoordinates()).map(Math.round); var text = feature.getStyle().getText().getText(); coord.push(text); return coord})"
      )
    end
  end
end
