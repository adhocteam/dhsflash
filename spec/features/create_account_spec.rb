require 'rails_helper'

describe 'the signup process', type: :feature do
  context 'with the new account form filled out' do
    before do
      visit '/users/sign_up'
      within('form') do
        fill_in 'Email', with: Faker::Internet.email
        fill_in 'Username', with: Faker::Internet.user_name
        fill_in 'First name', with: Faker::Name.first_name
        fill_in 'Last name', with: Faker::Name.last_name
        fill_in 'Password', with: 'abc-123'
        fill_in 'Password confirmation', with: 'abc-123'
        click_button 'Log in'
      end
    end

    it 'has signed me in' do
      expect(page).to have_content 'Signed in successfully'
      expect(page).to have_content 'Log Out'
    end

    it 'takes me to the dashboard' do
      expect(current_path).to eq(dashboard_path)
    end
  end
end
