require 'rails_helper'

describe 'As a user/admin' do
  before(:each) do
    DatabaseCleaner.clean
    @user = create(:user)
    @station1 = create(:station)
    @station2 = create(:station)
    @station3 = create(:station)

    create(:condition)
    @trips_from_station = create_list(:trip, 3, start_station: @station1, end_station: @station2)
    create_list(:trip, 5, start_station: @station3, end_station: @station1)
    @trips_end_station = create_list(:trip, 4, start_station: @station2, end_station: @station1)
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  context 'when I visit a station show page' do

    scenario 'I should see the number of trips to/from this station' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit "/#{@station1.slug}"

      expect(page).to have_content("Trips from here: #{@station1.start_trips.length}")
      expect(page).to have_content("Trips to here: #{@station1.end_trips.length}")
    end

    scenario 'I should see the most frequent destination' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit "/#{@station1.slug}"

      expect(page).to have_content("Most frequent destination: #{@station1.most_frequent_destination.name}")
      expect(page).to have_link(@station1.most_frequent_destination.name)

      click_on @station1.most_frequent_destination.name
      expect(current_path).to eq("/#{@station1.most_frequent_destination.slug}")
    end

    scenario 'I should see the most frequent origin' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit "/#{@station1.slug}"

      expect(page).to have_content("Most frequent origin: #{@station1.most_frequent_origin.name}")
      expect(page).to have_link(@station1.most_frequent_origin.name)

      click_on @station1.most_frequent_origin.name
      expect(current_path).to eq("/#{@station1.most_frequent_origin.slug}")
    end

    scenario 'I should see the date with the most trips from here' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit "/#{@station1.slug}"

      expect(page).to have_content("Date with most trips from here: #{@station1.date_with_most_trips.strftime('%d %B %Y')}")
    end

    scenario 'I should see the most frequent zip code for users of this station' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit "/#{@station1.slug}"

      expect(page).to have_content("Most frequent zip code for users of this station: #{@station1.most_frequent_zip_code}")
    end

    scenario 'I should see the most frequently used bike at this station' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit "/#{@station1.slug}"

      expect(page).to have_content("Most frequently used bike at this station: #{@station1.most_frequent_bike}")
    end
  end
end
