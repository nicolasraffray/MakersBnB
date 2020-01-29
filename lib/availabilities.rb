require_relative '../connection_setup'

class Avail < Sequel::Model
  def self.new_avail(place_id:, dates:)
    Avail.create(placesid: place_id, dates: dates )
  end 

  def self.show_all(place_id)
    date_string = Avail.where(placesid: place_id).map(:dates)[0]
    date_string[1..-2]
  end
end 