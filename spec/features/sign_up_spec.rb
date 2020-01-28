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
end
