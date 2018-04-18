require 'rails_helper'

describe 'admin visits condition#show' do
  before(:each) do
    @admin = create(:admin)
    @condition = create(:condition)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  scenario 'it shows all the attributs' do
    visit condition_path(@condition)

    expect(page).to have_content(@condition.date.strftime('%d %B %Y'))
    expect(page).to have_content(@condition.max_temperature)
    expect(page).to have_content(@condition.mean_temperature)
    expect(page).to have_content(@condition.min_temperature)
    expect(page).to have_content(@condition.mean_humidity)
    expect(page).to have_content(@condition.mean_visibility)
    expect(page).to have_content(@condition.mean_wind_speed)
    expect(page).to have_content(@condition.precipitation)
  end
end
