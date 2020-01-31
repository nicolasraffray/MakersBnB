require 'bookings'

describe Booking do 
  
  before(:each) do 
    @user = User.first
    @place = Place.first
  end 

  describe '.new_booking' do 

    it 'creates a new booking for an available date' do 
      booking = Booking.new_booking(place_id: @place.id, user_id: @user.id, dates: '02/01/2020 - 06/01/2020')
      expect(booking.bookingfrom.strftime("%Y-%m-%d")).to eq '2020-01-02'
      expect(booking.bookingto.strftime("%Y-%m-%d")).to eq '2020-01-06'
      expect(booking.confirm).to eq false
    end 
  end 
    
  describe '.confirm_booking' do 
    it 'excludes a new booking if there no availability' do 
      expect(Booking.new_booking(place_id: @place.id,user_id: @user.id, dates: '02/01/2020 - 10/01/2021')).to eq "There is no Availability"
    end 

    it 'excludes a new booking if there is already a booking there' do 
      booking1 = Booking.new_booking(place_id: @place.id, user_id: @user.id, dates: '02/01/2020 - 06/01/2020')
      booking2 = Booking.new_booking(place_id: @place.id,user_id: @user.id, dates: '02/01/2020 - 06/01/2020')
      Booking.confirm_booking(booking2.id)
      expect(Booking.confirm_booking(booking1.id)).to eq "There is no Availability"
    end 

    it 'there exist a booking with a larger range than the requested booking' do 
      booking1 = Booking.new_booking(place_id: @place.id, user_id: @user.id, dates: '02/11/2020 - 30/11/2020')
      booking2 = Booking.new_booking(place_id: @place.id,user_id: @user.id, dates: '03/11/2020 - 06/11/2020')
      Booking.confirm_booking(booking1.id)
      expect(Booking.confirm_booking(booking2.id)).to eq "There is no Availability"
    end 

    it 'there exists a booking with a smaller range than the requested booking' do 
      booking1 = Booking.new_booking(place_id: @place.id, user_id: @user.id, dates: '07/10/2020 - 14/10/2020')
      booking2 = Booking.new_booking(place_id: @place.id,user_id: @user.id, dates: '03/10/2020 - 18/10/2020')
      Booking.confirm_booking(booking1.id)
      expect(Booking.confirm_booking(booking2.id)).to eq "There is no Availability"
    end 

    it 'there exists a booking with a start date overlap with the requested booking' do 
      booking1 = Booking.new_booking(place_id: @place.id, user_id: @user.id, dates: '07/09/2020 - 14/09/2020')
      booking2 = Booking.new_booking(place_id: @place.id,user_id: @user.id, dates: '03/09/2020 - 09/09/2020')
      Booking.confirm_booking(booking1.id)
      expect(Booking.confirm_booking(booking2.id)).to eq "There is no Availability"
    end

    it 'there exists a booking with a end date overlap with the start of the requested booking' do 
      booking1 = Booking.new_booking(place_id: @place.id, user_id: @user.id, dates: '07/08/2020 - 14/08/2020')
      booking2 = Booking.new_booking(place_id: @place.id,user_id: @user.id, dates: '13/08/2020 - 19/08/2020')
      Booking.confirm_booking(booking1.id)
      expect(Booking.confirm_booking(booking2.id)).to eq "There is no Availability"
    end 

    it 'allows a booking to be made inbetween two other bookings' do
      booking1 = Booking.new_booking(place_id: @place.id, user_id: @user.id, dates: '07/03/2020 - 10/03/2020') 
      booking2 = Booking.new_booking(place_id: @place.id, user_id: @user.id, dates: '15/03/2020 - 20/03/2020')
      booking3 = Booking.new_booking(place_id: @place.id,user_id: @user.id, dates: '11/03/2020 - 14/03/2020')
      
      Booking.confirm_booking(booking1.id)
      Booking.confirm_booking(booking2.id)
      
      expect(Booking.confirm_booking(booking3.id)).not_to eq "There is no Availability"
    end 
  end 
end
