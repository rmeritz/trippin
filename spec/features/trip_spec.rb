require 'rails_helper'

RSpec.feature "trip planning" do
  scenario "creating a trip" do
    visit new_trip_path
    fill_in I18n.t("helpers.label.trip.title"), with: "Florida"
    click_on I18n.t("helpers.submit.trip.create")
    expect(page).to have_text "Florida"
  end
end
