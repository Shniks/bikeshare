require 'rails_helper'

describe 'The trips dashboard' do

  before(:each) do
    @date = Time.parse("2018/04/16")
    @user = create(:user)
    @station1 = Station.create!(
      name: 'bob',
      dock_count: 10,
      city: 'Modena',
      installation_date: Date.new(2012,10,4),
      slug: 'bob'
    )

    @station2 = Station.create!(
      name: 'sally',
      dock_count: 35,
      city: 'West',
      installation_date: Date.new(2012,10,4),
      slug: 'sally'
    )

    end_date = @date + 1.hours + 13.minutes + 2.seconds
    end_date_2 = @date + 24.hours + 13.minutes + 2.seconds

    @condition = Condition.create!(date: Date.parse("2018/04/16"), max_temperature: 80, mean_temperature: 84, min_temperature: 80, mean_humidity: 99, precipitation: 0, mean_wind_speed: 4, mean_visibility: 9)
    @condition_2 = Condition.create!(date: Date.parse("2018/04/17"), max_temperature: 80, mean_temperature: 84, min_temperature: 80, mean_humidity: 99, precipitation: 0, mean_wind_speed: 4, mean_visibility: 9)

    @trip_1 = Trip.create!(
      duration: 45,
      start_date: @date,
      end_date: end_date,
      bike_id: 1,
      subscription_type: 'Subscriber',
      zip_code: 80202,
      start_station_id: 1,
      end_station_id: 1,
      condition: @condition
    )

    @trip_2 = Trip.create(
      duration: 55,
      start_date: @date,
      end_date: end_date,
      bike_id: 2,
      subscription_type: 'Customer',
      zip_code: 80202,
      start_station_id: 1,
      end_station_id: 2,
      condition: @condition
    )

    @trip_3 = Trip.create(
      duration: 50,
      start_date: @date,
      end_date: end_date,
      bike_id: 2,
      subscription_type: 'Customer',
      zip_code: 80202,
      start_station_id: 1,
      end_station_id: 2,
      condition: @condition
    )

    @trip4 = Trip.create!(
      duration: 50,
      start_date: @date,
      end_date: end_date_2,
      bike_id: 2,
      subscription_type: 'Customer',
      zip_code: 80202,
      start_station_id: 2,
      end_station_id: 2,
      condition: @condition_2
    )
  end

  describe 'for a user or admin' do
    it 'has the average duration' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content('Average Duration: 50.0 seconds')
    end
  end

  describe 'for a user or admin' do
    it 'has the longest duration' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content('Longest Ride: 55 seconds')
    end
  end

  describe 'for a user or admin' do
    it 'has the shortest ride duration' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content('Shortest Ride: 45 seconds')
    end
  end

  describe 'for a user or admin' do
    it 'has the station with most rides as a starting place' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content("Most Popular Start Station: #{@station1.name}")
    end
  end

  describe 'for a user or admin' do
    it 'has the station with most rides as a ending place' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content("Most Popular End Station: #{@station2.name}")
    end
  end

  describe 'for a user or admin' do
    it 'has the most ridden bike with total number of rides for that bike' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content("Most Ridden Bike: 2, with 3 rides")
    end
  end

  describe 'for a user or admin' do
    it 'has the least ridden bike with total number of rides for that bike' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content("Least Ridden Bike: 1, with 1 rides")
    end
  end

  describe 'for a user or admin' do
    it 'has the user subscription type breakout with both count and percentage' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content("User Subscription Type: 3 customer(s) account for 75.0% of total.")
      expect(page).to have_content("User Subscription Type: 1 subscriber(s) account for 25.0% of total.")
    end
  end

  describe 'for a user or admin' do
    it 'has the date with the highest number of rides and the count' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content("Date with the most rides: #{Trip.date_with_most_rides}, number of rides: 3")
    end
  end

  describe 'for a user or admin' do
    it 'has the date with the least number of rides and the count' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content("Date with the least rides: #{Trip.date_with_least_rides}, number of rides: 1")
    end
  end

  describe 'for a user or admin' do
    it 'can see the weather on the day with the highest rides' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content('High Temperature: 80F')
      expect(page).to have_content('Average Temperature: 84F')
      expect(page).to have_content('Low Temperature: 80F')
      expect(page).to have_content('Average Humidity: 99%')
      expect(page).to have_content('Average Visibility: 9 miles')
      expect(page).to have_content('Average Wind Speed: 4 knots')
      expect(page).to have_content('Average Precipitation: 0.0 inches')
    end
  end

  describe 'for a user or admin' do
    it 'can see the weather on the day with the lowest rides' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/trips-dashboard'

      expect(page).to have_content('High Temperature: 80F')
      expect(page).to have_content('Average Temperature: 84F')
      expect(page).to have_content('Low Temperature: 80F')
      expect(page).to have_content('Average Humidity: 99%')
      expect(page).to have_content('Average Visibility: 9 miles')
      expect(page).to have_content('Average Wind Speed: 4 knots')
      expect(page).to have_content('Average Precipitation: 0.0 inches')
    end
  end
end
