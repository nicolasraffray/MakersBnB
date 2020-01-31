require_relative '../connection_setup'

class Booking < Sequel::Model


  def self.new_booking(place_id:, user_id:, dates:)
    # We dont want to create booking outside of availability
    dates = dates.split(' - ')
    bookingfrom = Date.parse(dates[0])
    bookingto = Date.parse(dates[1])

    avail_from = Avail.where(placesid: place_id).map(:start)[0]
    avail_to = Avail.where(placesid: place_id).map(:end)[0]

    if avail_from <= bookingfrom && avail_to >= bookingto
      Booking.create(userid: user_id, placesid: place_id, bookingfrom: bookingfrom, bookingto: bookingto)
    else 
      "There is no Availability"
    end 
  end 
    
  def self.confirm_booking(booking_id)

    place_id = Booking.where(id: booking_id).map(:placesid)[0]
    bookingfrom = Booking.where(id: booking_id).map(:bookingfrom)[0]
    bookingto = Booking.where(id: booking_id).map(:bookingto)[0]

    place_book_array = Booking.where(placesid: place_id).where(confirm: true).map([:bookingfrom, :bookingto])

    x = place_book_array.select do |x|
      (x[0]..x[1]).include?(bookingfrom) || (x[0]..x[1]).include?(bookingto) || (bookingfrom..bookingto).include?(x[0]) || (bookingfrom..bookingto).include?(x[1]) 
    end.empty?

    if x 
      Booking.where(id: booking_id).update(confirm: true)
    else
      "There is no Availability"
    end
  end
end 