require 'rails_helper'

describe 'the signup process', type: :feature do
  context 'with the new account form filled out' do
    let(:email) { Faker::Internet.email }

    before do
      visit '/users/sign_up'
      within('form') do
        fill_in 'Email', with: email
        fill_in 'Username', with: Faker::Internet.user_name
        fill_in 'First name', with: Faker::Name.first_name
        fill_in 'Last name', with: Faker::Name.last_name
        find('#user_password').set('abc-123')
        fill_in 'Password confirmation', with: 'abc-123'
        click_button 'Sign up'
      end
    end

    it 'has created an account' do
      user = User.where(email: email).first
      expect(user).to be
      expect(user.confirmed_at).to be_nil
      expect(page).to have_content 'A message with a confirmation link has been sent to your email address'
      expect(page).to have_content 'Log In'
    end

    it 'takes me to the dashboard' do
      expect(current_path).to eq(root_path)
    end
  end
end
