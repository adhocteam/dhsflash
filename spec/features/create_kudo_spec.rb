require 'rails_helper'

describe 'creating a kudo', type: :feature, js: true do
  context 'from the dashboard' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:recipient) { FactoryGirl.create(:user, username: 'brianeno') }

    before do
      login_as(user, scope: :user)
      visit '/dashboard'
    end

    it 'should create the kudo' do
      pending("remote kudo creation")
      find('#kudo_message').set('This is a cheesy kudo')
      find('#kudo_recipient_id').select(recipient.username)
      click_button 'Post Kudo'
      expect(current_path).to eq(dashboard_path)
      expect(Kudo.where(message: 'This is a cheesy kudo').first).to be
      expect(page).to have_content('This is a cheesy kudo')
    end

    it 'should fail without a message' do
      pending("remote kudo creation")
      click_button 'Post Kudo'
      find('#kudo_recipient_id').select(recipient.username)
      expect(current_path).to eq('/kudos')
      expect(Kudo.count).to eq(0)
      expect(page).to have_content('Message can\'t be blank')
    end

    it 'should fail without a recipient' do
      pending("remote kudo creation")
      find('#kudo_message').set('This is a cheesy kudo')
      click_button 'Post Kudo'
      expect(current_path).to eq('/dashboard')
      expect(Kudo.count).to eq(0)
      expect(page).to have_content('Recipient must exist')
    end

    it 'should present autocompletion options' do
      find('.ah-ac-textfield').set('bri')
      assert_selector('.ah-ac-match', count: 1)
      find('.ah-ac-textfield').set('FOO')
      assert_selector('.ah-ac-match', count: 0)
      find('.ah-ac-textfield').set('bri')
      find('.ah-ac-match').click
      find('#kudo_message').set('Great job!')
      click_button 'Post Kudo'
      expect(current_path).to eq(dashboard_path)
      expect(Kudo.where(message: 'Great job!').first).to be
      expect(page).to have_content('Great job!')
    end
  end
end
