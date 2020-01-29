# frozen_string_literal: true

require 'user'

describe User do
  describe '.new_user' do
    it 'add a user to the database' do
      new_user = User.new_user(name: 'Umberto', username: 'uValente', email: 'mock@gmail.com', password: 'psw123', phone_number: 123_456_789)
      expect(new_user.name).to eq 'Umberto'
      expect(new_user.username).to eq 'uValente'
      expect(new_user.password).not_to eq 'psw123'
    end

    it 'encrypt the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('psw123')
      User.new_user(name: 'Umberto', username: 'uValente', email: 'mock@gmail.com', password: 'psw123', phone_number: 123_456_789)
    end
  end

  describe '.authenticate' do
    it 'returns nil given an incorrect username' do
      user = User.new_user(name: 'Umberto', username: 'uValente', email: 'mock@gmail.com', password: 'psw123', phone_number: 123_456_789)
      authenticated_user = User.authenticate(username: 'uValenteWRONG', password: 'psw123')

      expect(authenticated_user).to be_nil
    end

    it 'returns nil given an incorrect password' do
      user = User.new_user(name: 'Umberto', username: 'uValente', email: 'mock@gmail.com', password: 'psw123', phone_number: 123_456_789)
      authenticated_user = User.authenticate(username: 'uValente', password: 'psw123WRONG')

      expect(authenticated_user).to be_nil
    end

    it 'returns a user when given correct username and password' do
      user = User.new_user(name: 'Umberto', username: 'uValente', email: 'mock@gmail.com', password: 'psw123', phone_number: 123_456_789)
      authenticated_user = User.authenticate(username: 'uValente', password: 'psw123')

      expect(authenticated_user.id).to eq user.id
    end
  end
end
