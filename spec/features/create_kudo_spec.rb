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
      find('#kudo_recipient_id').select('brianeno')
      find('#kudo_category').select('Teamwork')
      attach_file('kudo_attachment', Rails.root.join('spec', 'fixtures', 'nice.gif'))
      click_button 'Post Kudo'
      expect(current_path).to eq(dashboard_path)
      sleep 1
      kudo = Kudo.where(message: 'This is a cheesy kudo').first
      expect(kudo).to be
      expect(kudo.attachment).to be
      expect(page).to have_content('This is a cheesy kudo')
      expect(page).to have_content('nice.gif')
    end

    it 'should fail without a message' do
      find('#kudo_recipient_id').select('brianeno')
      expect(find('form input[name="commit"]')[:disabled]).to be true
    end

    it 'should fail without a recipient' do
      find('#kudo_message').set('This is a cheesy kudo')
      expect(find('form input[name="commit"]')[:disabled]).to be true
    end

    it 'should clear the form' do
      find('#kudo_message').set('Great jams, bro')
      find('#kudo_category').set('Teamwork')
      find('#kudo_category').select('Teamwork')
      find('#kudo_recipient_id').select('brianeno')
      click_button 'Post Kudo'
      sleep 1
      expect(find('#kudo_message').value).to eq('')
      expect(find('#kudo_recipient_id').value).to eq('')
      expect(find('#kudo_category').value).to eq('')
    end
  end
end
