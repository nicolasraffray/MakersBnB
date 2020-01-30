require 'bookings'

describe Booking do 
  describe '.new_booking' do 
    it 'creates a new booking for an available date' do 
      user = User.first
      place = Place.first
      booking = Booking.new_booking(place_id: place.id, user_id: user.id, bookingfrom:'2020-01-02', bookingto: '2020-01-06')
      expect(booking.bookingfrom.strftime("%Y-%m-%d")).to eq '2020-01-02'
      expect(booking.bookingto.strftime("%Y-%m-%d")).to eq '2020-01-06'
    end 
  end 
end 