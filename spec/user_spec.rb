require 'user'

describe User do
  it 'encrypt the password using BCrypt' do
    expect(BCrypt::Password).to receive(:create).with('psw123')
    User.new_user(name: 'Umberto', username: 'uValente', email: 'mock@gmail.com', password: 'psw123', phone_number: 123456789)
  end
end
