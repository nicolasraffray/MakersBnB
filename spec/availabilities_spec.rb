# frozen_string_literal: true

require_relative '../lib/availabilities'

describe Avail do
  describe '.new_avail' do
    it 'returns all available dates for a specific house' do
      new_place = Place.first
      new_avail = Avail.new_avail(place_id: new_place.id, dates: '15/02/2020 - 18/02/2020')
      expect(new_avail.placesid).to eq new_place.id
      expect(new_avail.start).to eq Date.parse('2020-02-15')
      expect(new_avail.end).to eq Date.parse('2020-02-18')
    end
  end

  # describe '.show_all' do
  #   it 'shows the available dates for a given house' do
  #     expect(Avail.show_all(Place.first.id)).to eq '2020-01-01,2020-01-07'
  #   end
  # end
end
