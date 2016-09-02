require 'rails_helper'

describe 'the invitation process', type: :feature, js: true do
  context 'sending an invite' do
    let(:user) { FactoryGirl.create(:user) }
    let(:email) { Faker::Internet.email }

    before do
      login_as(user)
      visit '/users/invitation/new'
    end

    it 'should send an invite' do
      fill_in 'Email', with: email
      click_button 'Send Invite'
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      mail = ActionMailer::Base.deliveries.first
      expect(mail.to).to eq([email])
      expect(mail.subject).to eq('Invitation instructions')

      mail_source = mail.body.parts[0].body.raw_source
      mail_source =~ %r{(users/invitation/accept.*)}

      logout(:user)
      visit $1
      expect(page).to have_content('Create your account')
      fill_in 'Email', with: email
      fill_in 'Username', with: Faker::Internet.user_name
      fill_in 'First name', with: Faker::Name.first_name
      fill_in 'Last name', with: Faker::Name.last_name
      fill_in 'Title', with: Faker::Name.title
      find('#user_password').set('abc-123')
      fill_in 'Password confirmation', with: 'abc-123'
      click_button 'Create Account'

      user = User.where(email: email).first
      expect(user).to be
      expect(user.confirmed_at).to be
    end
  end
end
