# frozen_string_literal: true

feature 'testing the homepage' do
  scenario 'testing homepage works' do
    visit('/')
    expect(page).to have_button
  end
end
