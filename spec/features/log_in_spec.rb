feature "log_in" do
  scenario "logs a user in" do
    visit('/')
    user = User.new_user(name: 'Umberto', username: 'uValente', email: 'mock@gmail.com', password: 'psw123', phone_number: 123_456_789)
    click_button('Log In')
    fill_in 'username', with: 'uValente'
    fill_in 'password', with: 'psw123'
    click_button('Log In')
    expect(page).to have_content('welcome Umberto')
    expect(page).not_to have_content('Log In')
  end
end
