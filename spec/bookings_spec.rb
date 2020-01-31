require 'bookings'

describe Booking do 
  
  before(:each) do 
    @user = User.first
    @place = Place.first
  end 

  describe '.new_booking' do 

    it 'creates a new booking for an available date' do 
      booking = Booking.new_booking(place_id: @place.id, user_id: @user.id, bookingfrom:'2020-01-02', bookingto: '2020-01-06')
      expect(booking.bookingfrom.strftime("%Y-%m-%d")).to eq '2020-01-02'
      expect(booking.bookingto.strftime("%Y-%m-%d")).to eq '2020-01-06'
      expect(booking.confirm).to eq false
    end 
  end 
    
  describe '.confirm_booking' do 
    it 'excludes a new booking if there no availability' do 
      expect(Booking.new_booking(place_id: @place.id,user_id: @user.id, bookingfrom:'2020-01-02', bookingto: '2021-01-10')).to eq "There is no Availability"
    end 

    it 'excludes a new booking if there is already a booking there' do 
      booking1 = Booking.new_booking(place_id: @place.id, user_id: @user.id, bookingfrom:'2020-01-02', bookingto: '2020-01-06')
      booking2 = Booking.new_booking(place_id: @place.id,user_id: @user.id, bookingfrom:'2020-01-02', bookingto: '2020-01-06')
      Booking.confirm_booking(booking2.id)
      expect(Booking.confirm_booking(booking1.id)).to eq "There is no Availability"
    end 

    it 'there exist a booking with a larger range than the requested booking' do 
      booking1 = Booking.new_booking(place_id: @place.id, user_id: @user.id, bookingfrom:'2020-11-02', bookingto: '2020-11-30')
      booking2 = Booking.new_booking(place_id: @place.id,user_id: @user.id, bookingfrom:'2020-11-03', bookingto: '2020-11-06')
      Booking.confirm_booking(booking1.id)
      expect(Booking.confirm_booking(booking2.id)).to eq "There is no Availability"
    end 

    it 'there exists a booking with a smaller range than the requested booking' do 
      booking1 = Booking.new_booking(place_id: @place.id, user_id: @user.id, bookingfrom:'2020-10-07', bookingto: '2020-10-14')
      booking2 = Booking.new_booking(place_id: @place.id,user_id: @user.id, bookingfrom:'2020-10-03', bookingto: '2020-10-16')
      Booking.confirm_booking(booking1.id)
      expect(Booking.confirm_booking(booking2.id)).to eq "There is no Availability"
    end 

    it 'there exists a booking with a start date overlap with the requested booking' do 
      booking1 = Booking.new_booking(place_id: @place.id, user_id: @user.id, bookingfrom:'2020-09-07', bookingto: '2020-09-14')
      booking2 = Booking.new_booking(place_id: @place.id,user_id: @user.id, bookingfrom:'2020-09-03', bookingto: '2020-09-09')
      Booking.confirm_booking(booking1.id)
      expect(Booking.confirm_booking(booking2.id)).to eq "There is no Availability"
    end

    it 'there exists a booking with a end date overlap with the start of the requested booking' do 
      booking1 = Booking.new_booking(place_id: @place.id, user_id: @user.id, bookingfrom:'2020-08-07', bookingto: '2020-08-14')
      booking2 = Booking.new_booking(place_id: @place.id,user_id: @user.id, bookingfrom:'2020-08-13', bookingto: '2020-08-19')
      Booking.confirm_booking(booking1.id)
      expect(Booking.confirm_booking(booking2.id)).to eq "There is no Availability"
    end 

    it 'allows a booking to be made inbetween two other bookings' do
      booking1 = Booking.new_booking(place_id: @place.id, user_id: @user.id, bookingfrom:'2020-03-07', bookingto: '2020-03-10') 
      booking2 = Booking.new_booking(place_id: @place.id, user_id: @user.id, bookingfrom:'2020-03-15', bookingto: '2020-03-20')
      booking3 = Booking.new_booking(place_id: @place.id,user_id: @user.id, bookingfrom:'2020-03-11', bookingto: '2020-03-14')
      
      Booking.confirm_booking(booking1.id)
      Booking.confirm_booking(booking2.id)
      
      expect(Booking.confirm_booking(booking3.id)).not_to eq "There is no Availability"
    end 
  end 
end
