# frozen_string_literal: true

feature 'log_in' do
  scenario 'logs a user in' do
    visit('/')
    user = User.new_user(name: 'Umberto', username: 'uValente', email: 'mock@gmail.com', password: 'psw123', phone_number: 123_456_789)
    click_button('Sign In')
    fill_in 'username', with: 'uValente'
    fill_in 'password', with: 'psw123'
    within(:css, 'form.session-new') do
      click_button('Sign In')
    end
    expect(page).to have_content('Umberto, welcome to Makers BnB!')
    expect(page).not_to have_content('Sign In')
  end

  scenario 'return an error if the username is wrong' do
    visit('/')
    user = User.new_user(name: 'Umberto', username: 'uValente', email: 'mock@gmail.com', password: 'psw123', phone_number: 123_456_789)
    click_button('Sign In')
    fill_in 'username', with: 'uValentewrong'
    fill_in 'password', with: 'psw123'
    within(:css, 'form.session-new') do
      click_button('Sign In')
    end
    expect(page).to have_content('Please check your email or password')
  end

  scenario 'return an error if the password is wrong' do
    visit('/')
    user = User.new_user(name: 'Umberto', username: 'uValente', email: 'mock@gmail.com', password: 'psw123', phone_number: 123_456_789)
    click_button('Sign In')
    fill_in 'username', with: 'uValente'
    fill_in 'password', with: 'psw123wrong'
    within(:css, 'form.session-new') do
      click_button('Sign In')
    end
    expect(page).to have_content('Please check your email or password')
  end
end
