
def sign_in
  visit('/')
  click_button('Sign In')
  fill_in 'username', with: 'nic123'
  fill_in 'password', with: 'psw123090'
  click_button('Sign In')
end 
