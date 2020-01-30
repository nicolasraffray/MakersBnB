# frozen_string_literal: true

feature 'add listing' do
  scenario 'it lets user add a new listing' do
    visit('/')
    user = User.new_user(name: 'Umberto', username: 'uValente', email: 'mock@gmail.com', password: 'psw123', phone_number: 123_456_789)
    click_button('Sign In')
    fill_in 'username', with: 'uValente'
    fill_in 'password', with: 'psw123'
    within(:css, 'form.session-new') do
      click_button('Sign In')
    end
    click_button('Add Listing')
    fill_in 'listingtitle', with: 'Very cool penthouse in Milan'
    fill_in 'description', with: 'Incredible apartment on the top floor of the highest skyscraper in Milan'
    fill_in 'address', with: '76 Italy Road, Milan, 48012, IT'
    fill_in 'ppn', with: '342'
    click_button('Publish')
    expect(page).to have_content('Very cool penthouse in Milan')
    expect(page).to have_content('48012')
  end
end
