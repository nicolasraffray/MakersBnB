require_relative '../connection_setup'

class Booking < Sequel::Model

  def self.new_booking(place_id:, user_id:, bookingfrom:, bookingto:)
    Booking.create(userid: user_id, placesid: place_id, bookingfrom: bookingfrom, bookingto: bookingto)
  end 


end 