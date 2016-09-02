require 'rails_helper'

describe 'notifying the user on new kudos', type: :feature, js: true do
  context 'with a recipient who gets all notifications' do
    let!(:creator) { FactoryGirl.create(:user) }
    let!(:recipient) { FactoryGirl.create(:user, notification_frequency: 'all', notification_method: 'email', username: 'bozo') }

    it 'should send them an email' do
      login_as(creator)
      visit '/dashboard'
      find('.ah-ac-textfield').set('bozo')
      find('.ah-ac-match').click
      find('#kudo_message').set('You are a clown')
      find('#kudo_category').select('Teamwork')
      click_button 'Post Kudo'
      sleep 1
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      mail = ActionMailer::Base.deliveries.first
      expect(mail.to).to eq([recipient.email])
      expect(mail.subject).to eq("You received a new kudo from #{creator.username}")
    end
  end
end
