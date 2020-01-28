# frozen_string_literal: true

feature 'Testing infrastructure' do
  scenario 'Can run app and check page content' do
    visit('/')
    expect(page).to have_content('Welcome to BnB!')
  end
end
