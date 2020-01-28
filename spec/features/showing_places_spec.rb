feature 'showing places' do 
  scenario 'showing places' do 
    new_user = User.new_user(name: 'Umberto', username: 'uValente', email: 'mock@gmail.com', password: 'psw123', phone_number: 123_456_789)
    Place.new_place(user_id: new_user.id, listing_title: '1 Bedroom Apartment', description: 'Lovely 1 bed apartment in the middle of London', address: 'Best Road', ppn: 113.27)
    Place.new_place(user_id: new_user.id, listing_title: 'cool apartment', description: 'Lovely 1 bed apartment in north london ', address: 'nicest Road', ppn: 178.27)
    visit ('/')
    click_button('Show all')
    expect(page).to have_content('1 Bedroom Apartment')
    expect(page).to have_content('Lovely 1 bed apartment in the middle of London')
    expect(page).to have_content('Best Road')
    expect(page).to have_content('178.27')
    expect(page).to have_content('cool apartment')
  end 
end 