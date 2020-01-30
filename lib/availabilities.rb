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
    date_string = Avail.where(placesid: place_id).map(:dates)[0]
    date_string[1..-2]
  end
end
