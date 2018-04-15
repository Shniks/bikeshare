require 'rails_helper'

describe 'admin visits trips#index' do
  before(:each) do
    @admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    @station = create(:station)
    @condition = create(:condition)
    @trips = create_list(:trip, 5)
  end

  scenario 'it shows all the attributes' do
    visit trips_path

    @trips.each do |trip|
      expect(page).to have_content(trip.time_string)
      expect(page).to have_content(trip.start_date)
      expect(page).to have_content(trip.end_date)
      expect(page).to have_content(trip.bike_id)
      expect(page).to have_content(trip.subscription_type)
      expect(page).to have_content(trip.zip_code)
      expect(page).to have_content(trip.start_station_id)
      expect(page).to have_content(trip.end_station_id)
    end
  end
end
