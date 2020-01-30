require_relative '../web_helpers.rb'

feature 'adding a place with availability' do 
  scenario 'puts in initial range of available dates for teh appartment' do 
    sign_in
    click_button('Add Listing')
    fill_in 'listingtitle', with: 'Very cool penthouse in Milan'
    fill_in 'description', with: 'Incredible apartment on the top floor of the highest skyscraper in Milan'
    fill_in 'address', with: '76 Italy Road, Milan, 48012, IT'
    fill_in 'ppn', with: '342'
    fill_in 'From', with: '2020-02-01'
    fill_in 'To', with: '2020-02-14'
    click_button('Publish')
    expect(page).to have_content('2020-02-01')
    expect(page).to have_content('2020-02-14')
  end
end 
