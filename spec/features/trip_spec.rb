require 'rails_helper'

RSpec.feature "trip planning" do
  scenario "creating a trip" do
    visit new_trip_path
    fill_in I18n.t("helpers.label.trip.title"), with: "Florida"
    click_on I18n.t("helpers.submit.trip.create")
    expect(page).to have_text "Florida"
  end

  scenario "adding a starting point to a trip" do
    trip = FactoryGirl.create :trip
    visit trip_path trip
    fill_in I18n.t("helpers.label.point_creator.location"), with: "Orlando"
    click_on I18n.t("helpers.submit.point_creator.create")
    expect(page).to have_a_map_with_a_point "Orlando, FL"
  end
end
