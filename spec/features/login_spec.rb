require 'rails_helper'

describe 'the signin process', type: :feature do
  let(:user) { create(:user, password: 'abc-123', password_confirmation: 'abc-123') }

  before do
    user
  end

  context 'with the login form filled out' do
    before do
      visit '/users/sign_in'
      within('form') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'abc-123'
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

  context 'when providing bogus data' do
    it 'should not log me in when entering a bad password' do
      visit '/users/sign_in'
      within('form') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'ZZZZZZ'
        click_button 'Log in'
      end
      expect(page).to have_content 'Invalid Email or password'
      expect(page).to have_content 'Log In'
      expect(current_path).to eq(new_user_session_path)
    end

    it 'should not log me in when entering a bad username' do
      visit '/users/sign_in'
      within('form') do
        fill_in 'Email', with: 'blat@hack.com'
        fill_in 'Password', with: 'abd-123'
        click_button 'Log in'
      end
      expect(page).to have_content 'Invalid Email or password'
      expect(page).to have_content 'Log In'
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
