require 'rails_helper'

describe 'limiting kudos to one per day', type: :feature, js: true do
  context 'from the dashboard' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:recipient) { FactoryGirl.create(:user, username: 'brianeno') }

    before do
      login_as(user, scope: :user)
      visit '/dashboard'
    end

    it 'should block me' do
      find('#kudo_message').set('This is the first kudo')
      find('#kudo_recipient_id').select('brianeno')
      find('#kudo_category').select('Teamwork')
      click_button 'Post Kudo'
      expect(current_path).to eq(dashboard_path)
      sleep 1
      expect(Kudo.where(message: 'This is the first kudo').first).to be
      expect(page).to have_content('This is the first kudo')

      visit '/dashboard'
      find('#kudo_message').set('This is the second kudo')
      find('#kudo_recipient_id').select('brianeno')
      find('#kudo_category').select('Teamwork')
      click_button 'Post Kudo'
      expect(Kudo.where(message: 'This is the second kudo').first).to_not be
      expect(page).to have_content('Recipient can only receive one point from you per day')
    end
  end
end
