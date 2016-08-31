require 'rails_helper'

describe 'creating a thumbs up', type: :feature do
  context 'from the dashboard' do
    let!(:creator) { FactoryGirl.create(:user) }
    let!(:recipient) { FactoryGirl.create(:user) }
    let!(:thumbs_upper) { FactoryGirl.create(:user) }

    before do
      login_as(creator)
      visit '/dashboard'
      find('#kudo_message').set('This is a cheesy kudo')
      find('#kudo_recipient_id').select(recipient.username)
      click_button 'Post Kudo'
      login_as(thumbs_upper)
      visit '/dashboard'
      within("#kudo-#{Kudo.first.id}") do
        page.find('.thumbs-up').click
      end
    end

    it 'should create a thumbs up' do
      expect(ThumbsUp.count).to eq(1)
    end
  end
end
