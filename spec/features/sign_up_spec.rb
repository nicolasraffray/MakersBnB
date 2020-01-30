# frozen_string_literal: true

feature 'checks user can sign up' do
  scenario 'checks user can sign up' do
    visit '/'
    click_button 'Sign Up'
    fill_in 'name', with: 'umberto'
    fill_in 'email', with: 'user1@gmail.com'
    fill_in 'username', with: 'userone'
    fill_in 'password', with: 'secret'
    fill_in 'phonenumber', with: '12345678911'
    click_button 'Register'
    expect(page).to have_content('umberto, welcome')
    expect(page).not_to have_content('Sign Up')
  end

  scenario 'return a username error if username is already registered' do
    visit '/'
    click_button 'Sign Up'
    fill_in 'name', with: 'umberto'
    fill_in 'email', with: 'user1@gmail.com'
    fill_in 'username', with: 'userone'
    fill_in 'password', with: 'secret'
    fill_in 'phonenumber', with: '12345678911'
    click_button 'Register'
    click_button 'Sign Out'
    click_button 'Sign Up'
    fill_in 'name', with: 'umberto'
    fill_in 'email', with: 'user1@gmail.com'
    fill_in 'username', with: 'userone'
    fill_in 'password', with: 'secret'
    fill_in 'phonenumber', with: '12345678911'
    click_button 'Register'
    expect(page).to have_content('Username already in use')
  end

  scenario 'return a email error if email is already registered' do
    visit '/'
    click_button 'Sign Up'
    fill_in 'name', with: 'umberto'
    fill_in 'email', with: 'user1@gmail.com'
    fill_in 'username', with: 'userone'
    fill_in 'password', with: 'secret'
    fill_in 'phonenumber', with: '12345678911'
    click_button 'Register'
    click_button 'Sign Out'
    click_button 'Sign Up'
    fill_in 'name', with: 'umberto'
    fill_in 'email', with: 'user1@gmail.com'
    fill_in 'username', with: 'useroneplus'
    fill_in 'password', with: 'secret'
    fill_in 'phonenumber', with: '12345678911'
    click_button 'Register'
    expect(page).to have_content('Email already in use')
  end

  scenario 'return a email error if email is already registered' do
    visit '/'
    click_button 'Sign Up'
    fill_in 'name', with: 'umberto'
    fill_in 'email', with: 'user1@gmail.com'
    fill_in 'username', with: 'userone'
    fill_in 'password', with: 'secret'
    fill_in 'phonenumber', with: '12345678911'
    click_button 'Register'
    click_button 'Sign Out'
    click_button 'Sign Up'
    fill_in 'name', with: 'umberto'
    fill_in 'email', with: 'user1plus@gmail.com'
    fill_in 'username', with: 'useroneplus'
    fill_in 'password', with: 'secret'
    fill_in 'phonenumber', with: '12345678911'
    click_button 'Register'
    expect(page).to have_content('Phone number already in use')
  end
end
