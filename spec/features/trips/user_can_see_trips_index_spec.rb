require 'rails_helper'

describe 'As a Visitor' do
  describe 'When I visit the trips index' do
    scenario 'I see the first 30 trips along with a button to see more pages of trips' do
      station = create(:station)
      trips = create_list(:trip, 80)

      visit trips_path

      trips.each do |trip|
        expect(page).to have_content(trip.id)
        expect(page).to have_content(trip.duration)
        expect(page).to have_content(trip.start_date)
        expect(page).to have_content(trip.start_station_name)
        expect(page).to have_content(trip.end_date)
        expect(page).to have_content(trip.end_station_name)
        expect(page).to have_content(trip.bike_id)
        expect(page).to have_content(trip.subscription_type)
        expect(page).to have_content(trip.zip_code)
      end
      expect(page).to have_content(trips[29].id)
      expect(page).to_not have_content("Trip no.: #{trips[30].id}")
      expect(page).to_not have_content("Trip no.: #{trips[31].id}")

      click_on 'Next'

      expect(page).to have_content(trips[30].id)
      expect(page).to have_content(trips[59].id)
      expect(page).to_not have_content("Trip no.: #{trips[29].id}")
      expect(page).to_not have_content("Trip no.: #{trips[60].id}")
    end
  end
end
