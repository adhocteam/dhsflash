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
      find('#kudo_message').set('This is a cheesy kudo')
      find('.ah-ac-textfield').set('bri')
      find('.ah-ac-match').click
      find('#kudo_category').select('Teamwork')
      click_button 'Post Kudo'
      expect(current_path).to eq(dashboard_path)
      sleep 1
      expect(Kudo.where(message: 'This is a cheesy kudo').first).to be
      expect(page).to have_content('This is a cheesy kudo')
    end

    it 'should fail without a message' do
      find('.ah-ac-textfield').set('bri')
      find('.ah-ac-match').click
      expect(find('form input[name="commit"]')[:disabled]).to be true
    end

    it 'should fail without a recipient' do
      find('#kudo_message').set('This is a cheesy kudo')
      expect(find('form input[name="commit"]')[:disabled]).to be true
    end

    it 'should present autocompletion options' do
      find('.ah-ac-textfield').set('bri')
      assert_selector('.ah-ac-match', count: 1)
      find('.ah-ac-textfield').set('FOO')
      assert_selector('.ah-ac-match', count: 0)
      find('.ah-ac-textfield').set('bri')
      find('.ah-ac-match').click
      find('#kudo_message').set('Great job!')
      find('#kudo_category').select('Teamwork')
      click_button 'Post Kudo'
      expect(current_path).to eq(dashboard_path)
      sleep 1
      expect(Kudo.where(message: 'Great job!').first).to be
      expect(page).to have_content('Great job!')
    end

    it 'should clear the form' do
      find('#kudo_message').set('Great jams, bro')
      find('#kudo_category').set('Teamwork')
      find('#kudo_category').select('Teamwork')
      find('.ah-ac-textfield').set('bri')
      find('.ah-ac-match').click
      click_button 'Post Kudo'
      sleep 1
      expect(find('#kudo_message').value).to eq('')
      expect(find('.ah-ac-textfield').value).to eq('')
      expect(find('#kudo_category').value).to eq('')
    end
  end
end
