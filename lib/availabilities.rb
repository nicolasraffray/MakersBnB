require_relative '../connection_setup'
require 'date'

class Avail < Sequel::Model
  def self.new_avail(place_id:, dates:)
    dates = dates.split(' - ')
    from = Date.parse(dates[0])
    to = Date.parse(dates[1])
    Avail.create(placesid: place_id, start: from, end: to)
  end

  def self.show_all(place_id)
    from = Avail.where(placesid: place_id).map(:start)[0].strftime("%Y-%m-%d")
    to = Avail.where(placesid: place_id).map(:end)[0].strftime("%Y-%m-%d")

    from + " " + to     
  end
end
