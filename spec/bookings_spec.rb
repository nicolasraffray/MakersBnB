require 'bookings'

describe Booking do 
  describe '.new_booking' do 
    
    before(:each) do 
      @user = User.first
      @place = Place.first
    end 

    it 'creates a new booking for an available date' do 
      booking = Booking.new_booking(place_id: @place.id, user_id: @user.id, bookingfrom:'2020-01-02', bookingto: '2020-01-06')
      expect(booking.bookingfrom.strftime("%Y-%m-%d")).to eq '2020-01-02'
      expect(booking.bookingto.strftime("%Y-%m-%d")).to eq '2020-01-06'
    end 

    it 'excludes a new booking if there no availability' do 
      expect(Booking.new_booking(place_id: @place.id,user_id: @user.id, bookingfrom:'2020-01-02', bookingto: '2021-01-10')).to eq "There is no Availability"
    end 

    it 'excludes a new booking if there is already a booking there' do 
      Booking.new_booking(place_id: @place.id, user_id: @user.id, bookingfrom:'2020-01-02', bookingto: '2020-01-06')
      expect(Booking.new_booking(place_id: @place.id,user_id: @user.id, bookingfrom:'2020-01-02', bookingto: '2020-01-06')).to eq "There is no Availability"
    end 

    it 'there exist a booking with a larger range than the requested booking' do 
      Booking.new_booking(place_id: @place.id, user_id: @user.id, bookingfrom:'2020-11-02', bookingto: '2020-11-30')
      expect(Booking.new_booking(place_id: @place.id,user_id: @user.id, bookingfrom:'2020-11-03', bookingto: '2020-11-06')).to eq "There is no Availability"
    end 

    it 'there exists a booking with a smaller range than the requested booking' do 
      Booking.new_booking(place_id: @place.id, user_id: @user.id, bookingfrom:'2020-10-07', bookingto: '2020-10-14')
      expect(Booking.new_booking(place_id: @place.id,user_id: @user.id, bookingfrom:'2020-10-03', bookingto: '2020-10-16')).to eq "There is no Availability"
    end 

    it 'there exists a booking with a start date overlap with the requested booking' do 
      Booking.new_booking(place_id: @place.id, user_id: @user.id, bookingfrom:'2020-09-07', bookingto: '2020-09-14')
      expect(Booking.new_booking(place_id: @place.id,user_id: @user.id, bookingfrom:'2020-09-03', bookingto: '2020-09-09')).to eq "There is no Availability"
    end

    it 'there exists a booking with a end date overlap with the start of the requested booking' do 
      Booking.new_booking(place_id: @place.id, user_id: @user.id, bookingfrom:'2020-08-07', bookingto: '2020-08-14')
      expect(Booking.new_booking(place_id: @place.id,user_id: @user.id, bookingfrom:'2020-08-13', bookingto: '2020-08-19')).to eq "There is no Availability"
    end 

    it 'allows a booking to be made inbetween two other bookings' do
      Booking.new_booking(place_id: @place.id, user_id: @user.id, bookingfrom:'2020-03-07', bookingto: '2020-03-10') 
      Booking.new_booking(place_id: @place.id, user_id: @user.id, bookingfrom:'2020-03-15', bookingto: '2020-03-20')
      expect(Booking.new_booking(place_id: @place.id,user_id: @user.id, bookingfrom:'2020-03-11', bookingto: '2020-03-14')).not_to eq "There is no Availability"
    end 
  end 
end