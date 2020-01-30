require_relative '../connection_setup'

class Avail < Sequel::Model
  def self.new_avail(place_id:, start:, to:)
    Avail.create(placesid: place_id, start: start, end: to)
  end 

  def self.show_all(place_id)
    from = Avail.where(placesid: place_id).map(:start)[0].strftime("%Y-%m-%d")
    to = Avail.where(placesid: place_id).map(:end)[0].strftime("%Y-%m-%d")

    from + " " + to     
  end
end 