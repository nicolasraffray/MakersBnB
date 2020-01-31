# frozen_string_literal: true

require 'pg'
require_relative '../lib/place'
require_relative '../lib/user'

def setup_test_database
  connection = PG.connect(dbname: 'bnb_test')
  connection.exec('TRUNCATE users, places, avails, bookings CASCADE;')
  new_user = User.new_user(name: 'Nic', username: 'nic123', email: 'mock123@gmail.com', password: 'psw123090', phone_number: 123_456_987)
  new_place = Place.new_place(user_id: new_user.id, listing_title: '1 Bedroom Apartment', description: 'Lovely 1 bed apartment in the middle of London', address: 'Some Road', ppn: 113.27)
  new_avail = Avail.create(placesid: new_place.id, start: '2020-01-01', end: '2021-01-07')
end
