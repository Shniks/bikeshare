class Trip < ApplicationRecord
  include ActionView::Helpers::TextHelper

  validates_presence_of :duration, :start_date, :start_station_id, :end_date, :end_station_id, :bike_id, :subscription_type

  belongs_to :start_station, class_name: 'Station'
  belongs_to :end_station, class_name: 'Station'
  belongs_to :condition

  def time_string
    seconds = duration

    values.reduce([]) do |string, (per, name)|
      if seconds > 0
        seconds, amt = seconds.divmod(per)
        string.unshift "#{pluralize(amt, name.to_s)}"
      end
      string
    end.join(', ')
  end

  private
  def values
    [
      [60, :second],
      [60, :minute],
      [24, :hour]
    ]
  end
end
