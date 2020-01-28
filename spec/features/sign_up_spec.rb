feature 'checks user can sign up' do 
  scenario 'checks user can sign up' do 
    visit ('/')
    click_button ('sign up')
    fill_in 'name', with: 'umberto'
    fill_in 'email', with: 'user1@gmail.com'
    fill_in 'username', with: 'userone'
    fill_in 'password', with: 'secret'
    fill_in 'phonenumber', with: '12345678911'
    click_button ('register')
    expect(page).to have_content('welcome umberto')
    expect(page).not_to have_content('sign up')
  end
  
end 