require 'rails_helper'

describe 'admin visits trips#edit' do
  before(:each) do
    @admin = create(:admin)
    @station = create(:station)
    @station2 = create(:station)
    @trip = create(:trip)
  end

  describe 'admin visit admin_trips#edit' do
    it 'allows the admin to create new station' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit edit_admin_trip_path(@trip)

      fill_in 'trip[duration]', with: 60
      fill_in 'trip[start_date]', with: '2018-01-09 18:27:55'
      fill_in 'trip[end_date]', with: '2018-01-09 22:27:55'
      fill_in 'trip[bike_id]', with: 8
      fill_in 'trip[subscription_type]', with: 'Premium'
      fill_in 'trip[zip_code]', with: 88888
      fill_in 'trip[start_station_id]', with: 1
      fill_in 'trip[end_station_id]', with: 2
      click_on 'Update Trip'

      expect(current_path).to eq(trip_path(@trip))
      expect(page).to have_content('2018-01-09 18:27:55')
      expect(page).to have_content('2018-01-09 22:27:55')
      expect(page).to have_content('8')
      expect(page).to have_content('Premium')
      expect(page).to have_content('88888')
      expect(page).to have_content('1')
      expect(page).to have_content('2')
    end
  end

  describe 'admin visit trips_path' do
    it 'to use edit trip link' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit trips_path

      click_link 'Edit'

      fill_in 'trip[duration]', with: 60
      fill_in 'trip[start_date]', with: '2018-01-09 18:27:55'
      fill_in 'trip[end_date]', with: '2018-01-09 22:27:55'
      fill_in 'trip[bike_id]', with: 8
      fill_in 'trip[subscription_type]', with: 'Premium'
      fill_in 'trip[zip_code]', with: 88888
      fill_in 'trip[start_station_id]', with: 1
      fill_in 'trip[end_station_id]', with: 2
      click_on 'Update Trip'

      expect(current_path).to eq(trip_path(@trip))
      expect(page).to have_content('2018-01-09 18:27:55')
      expect(page).to have_content('2018-01-09 22:27:55')
      expect(page).to have_content('8')
      expect(page).to have_content('Premium')
      expect(page).to have_content('88888')
      expect(page).to have_content('1')
      expect(page).to have_content('2')
    end
  end

  describe 'admin visit trips_path' do
    it 'to use edit trip link' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit trip_path(@trip)

      click_link 'Edit'

      fill_in 'trip[duration]', with: 60
      fill_in 'trip[start_date]', with: '2018-01-09 18:27:55'
      fill_in 'trip[end_date]', with: '2018-01-09 22:27:55'
      fill_in 'trip[bike_id]', with: 8
      fill_in 'trip[subscription_type]', with: 'Premium'
      fill_in 'trip[zip_code]', with: 88888
      fill_in 'trip[start_station_id]', with: 1
      fill_in 'trip[end_station_id]', with: 2
      click_on 'Update Trip'

      expect(current_path).to eq(trip_path(@trip))
      expect(page).to have_content('2018-01-09 18:27:55')
      expect(page).to have_content('2018-01-09 22:27:55')
      expect(page).to have_content('8')
      expect(page).to have_content('Premium')
      expect(page).to have_content('88888')
      expect(page).to have_content('1')
      expect(page).to have_content('2')
    end
  end

  describe 'as normal user' do
    it 'does not allow default user to see delete link' do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit edit_admin_trip_path(@trip)
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  describe 'as visitor' do
    it 'does not allow visitor to see delete link' do

      visit edit_admin_trip_path(@trip)
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
