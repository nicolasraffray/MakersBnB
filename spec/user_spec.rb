# frozen_string_literal: true

require 'user'

describe User do
  describe '.new_user' do
    it 'add a user to the database' do
      new_user = User.new_user(name: 'Umberto', username: 'uValente', email: 'mock@gmail.com', password: 'psw123', phone_number: 123_456_789)
      expect(User.all.length).to eq 1
      expect(new_user.name).to eq 'Umberto'
      expect(new_user.username).to eq 'uValente'
      expect(new_user.password).not_to eq 'psw123'
    end

    it 'encrypt the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('psw123')
      User.new_user(name: 'Umberto', username: 'uValente', email: 'mock@gmail.com', password: 'psw123', phone_number: 123_456_789)
    end
  end
end
