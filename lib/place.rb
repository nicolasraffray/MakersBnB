# frozen_string_literal: true

require_relative '../connection_setup'

class Place < Sequel::Model
  def self.new_place(user_id:, listing_title:, description:, address:, ppn:)
    Place.create(userid: user_id, listingtitle: listing_title, description: description, address: address, ppn: ppn)
  end
end
