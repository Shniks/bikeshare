require 'rails_helper'

describe 'As a Visitor' do
  describe 'When I visit a trip\'s show page' do
    scenario 'I can see all the attributes for that trip' do
      station = create(:station)
      condition = create(:condition)
      trips = create_list(:trip, 5)
      trip_1 = trips[3]

      visit trip_path(trip_1)

      expect(page).to have_content(trip_1.id)
      expect(page).to have_content(trip_1.time_string)
      expect(page).to have_content(trip_1.start_date.strftime('%d %B %Y'))
      expect(page).to have_content(trip_1.end_date.strftime('%d %B %Y'))
      expect(page).to have_content(trip_1.bike_id)
      expect(page).to have_content(trip_1.subscription_type)
      expect(page).to have_content(trip_1.zip_code)
      expect(page).to_not have_content("Trip no.: #{trips[0].id}")
      expect(page).to_not have_content("Trip no.: #{trips[4].id}")
    end
  end

  scenario 'it can link from the index page' do
    create(:station)
    condition = create(:condition)
    trip = create(:trip)

    visit trips_path

    click_link trip.id

    expect(current_path).to eq(trip_path(trip))
  end
end
