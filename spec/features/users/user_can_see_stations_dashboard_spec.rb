require 'rails_helper'

describe 'As a user/admin' do
  describe 'when I visit the stations dashboard' do
    before(:all) do
      DatabaseCleaner.clean
      @user = create(:user)

      Station.create!(
        name: 'Station A',
        dock_count: 5,
        city: 'San Francisco',
        installation_date: Date.new(2017, 10, 4)
      )
      Station.create!(
        name: 'Station B',
        dock_count: 10,
        city: 'Oakland',
        installation_date: Date.new(2016, 10, 4)
      )
      Station.create!(
        name: 'Station C',
        dock_count: 15,
        city: 'San Diego',
        installation_date: Date.new(2015, 10, 4)
      )
      Station.create!(
        name: 'Station D',
        dock_count: 20,
        city: 'Los Angeles',
        installation_date: Date.new(2014, 10, 4)
      )
      Station.create!(
        name: 'Station E',
        dock_count: 25,
        city: 'San Bernadino',
        installation_date: Date.new(2013, 10, 4)
      )

      @stations = Station.all
    end

    after(:all) do
      DatabaseCleaner.clean
    end

    scenario 'I should see the total number of stations' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit stations_dashboard

      expect(page).to have_content("Total number of stations: #{@stations.length}")
    end
  end
end