require_relative '../connection_setup'

class Booking < Sequel::Model

  def self.new_booking(place_id:, user_id:, bookingfrom:, bookingto:)
    
    bookingfrom = Date.parse(bookingfrom)
    bookingto = Date.parse(bookingto)

    avail_from = Avail.where(placesid: place_id).map(:start)[0]
    avail_to = Avail.where(placesid: place_id).map(:end)[0]

    place_book_array = Booking.where(placesid: place_id).map([:bookingfrom, :bookingto])

    x = place_book_array.select do |x|
      (x[0]..x[1]).include?(bookingfrom) || (x[0]..x[1]).include?(bookingto) || (bookingfrom..bookingto).include?(x[0]) || (bookingfrom..bookingto).include?(x[1]) 
    end.empty?

    if avail_from <= bookingfrom && avail_to >= bookingto && x 
      Booking.create(userid: user_id, placesid: place_id, bookingfrom: bookingfrom, bookingto: bookingto)
    else
      "There is no Availability"
    end
  end
end 