require_relative '../web_helpers'

feature 'User Listing Confirmation' do 
  scenario 'Clicks on Mylistings and can confirm unconfirmed booking' do 
    sign_in
    click_button("My Listing")
    expect(page).to have_content("1 Bedroom Apartment")
    expect(page).to have_content("Nic would like to book this property")
    click_button("Confirm")
    expect(page).to have_content("The booking is confirmed with Nic")
  end 
end
