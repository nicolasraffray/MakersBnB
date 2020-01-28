# frozen_string_literal: true

require_relative '../connection_setup'
require 'bcrypt'

class User < Sequel::Model
  def self.new_user(name:, email:, phone_number:, username:, password:)
    encrypted_password = BCrypt::Password.create(password)
  end
end
