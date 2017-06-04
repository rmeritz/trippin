require 'rails_helper'

RSpec.feature "trip planning" do
  scenario "creating a trip" do
    visit new_trip_path
    fill_in I18n.t("helpers.label.trip.title"), with: "Florida"
    click_on I18n.t("helpers.submit.trip.create")
    expect(page).to have_text "Florida"
  end

  scenario "adding a starting point to a trip", :js do
    trip = FactoryGirl.create :trip
    visit trip_path trip
    fill_in I18n.t("helpers.label.point_creator.location"), with: "Orlando"
    click_on I18n.t("helpers.submit.point_creator.create")
    expect(page).to have_a_map_with_a_point("Orlando, FL").at(28.538, -81.379)
  end

  private

  RSpec::Matchers.define :have_a_map_with_a_point do |name|
    match do |page|
      map_present? && feature_at_coordinates?
    end
    chain :at do |lat, long|
      @lat = lat
      @long = long
    end
    failure_message do
      if !@map_presence
        "The map canvas was missing."
      else
        "Expected #{[@lat, @long]} Actual #{[@actual_lat, @actual_lon]}"
      end
    end

    def map_present?
      @map_presence = find("#map").has_selector?("canvas")
    end

    def feature_at_coordinates?
       @actual_lon, @actual_lat = page.driver.evaluate_script(
         "ol.proj.toLonLat(map.getLayers().item(1).getSource().getFeatures()[0].getGeometry().getCoordinates())").map {|coord| coord.round(3) }
      [@lat, @long] == [@actual_lat, @actual_lon]
    end
  end
end
