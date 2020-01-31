require_relative '../web_helpers'

feature 'Booking functionality' do
  scenario 'a user makes a valid booking and can see the unconfirmed booking' do 
    sign_in
    click_link('Some Road')
    click_button('Book Me')
    fill_in 'dates', with: '02/01/2020 - 07/01/2020'
    click_button('Book Me')
    expect(page).to have_content("My Bookings")
    expect(page).to have_content('Unconfirmed')
    expect(page).to have_content('1 Bedroom Apartment')
    expect(page).to have_content('2020-01-02 - 2020-01-07')
  end 
end