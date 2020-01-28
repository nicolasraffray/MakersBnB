# frozen_string_literal: true

require 'place'

describe Place do
  describe '.new_place' do
    it 'add a place to the database and return an instance of Place' do
      new_user = User.new_user(name: 'Umberto', username: 'uValente', email: 'mock@gmail.com', password: 'psw123', phone_number: 123_456_789)
      new_place = Place.new_place(user_id: new_user.id, listing_title: '1 Bedroom Apartment', description: 'Lovely 1 bed apartment in the middle of London', address: 'Best Road', ppn: 113.27)

      expect(Place.all.length).to eq 1
      expect(new_place.listingtitle).to eq '1 Bedroom Apartment'
      expect(new_place.ppn).to eq 113.27
    end
  end
end
