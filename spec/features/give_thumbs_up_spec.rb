require 'rails_helper'

describe 'creating a thumbs up', type: :feature, js: true do
  context 'from the dashboard' do
    let(:creator) { FactoryGirl.create(:user, notification_frequency: 'all', notification_method: 'email') }
    let(:recipient) { FactoryGirl.create(:user, notification_frequency: 'all', notification_method: 'email') }
    let(:thumbs_upper) { FactoryGirl.create(:user) }
    let!(:kudo) { FactoryGirl.create(:kudo, creator: creator, recipient: recipient) }

    before do
      login_as(thumbs_upper)
      visit '/dashboard'
      within("#kudo-#{kudo.id}") do
        page.find('.thumbs-up').click
      end
      sleep(1)
    end

    it 'should create a thumbs up' do
      expect(kudo.thumbs_ups.count).to eq(1)
      expect(kudo.thumbs_ups.first.user).to eq(thumbs_upper)
      expect(kudo.thumbs_ups.first.kudo).to eq(kudo)
    end

    it 'should not let me thumbs up twice' do
      sleep(1)
      visit '/dashboard'
      within("#kudo-#{kudo.id}") do
        page.find('.thumbs-up').click
      end
      sleep(1)
      expect(kudo.thumbs_ups.count).to eq(1)
    end

    it 'should send an email to the recipient of the kudo' do
      mail = ActionMailer::Base.deliveries.select { |d| d.to.include?(recipient.email) }[1]
      expect(mail).to be
      expect(mail.subject).to eq("Your kudo from #{creator.username} received a thumbs up from #{thumbs_upper.username}")
    end

    it 'should send a kudo to the creator of the kudo' do
      mail = ActionMailer::Base.deliveries.find { |d| d.to.include?(creator.email) }
      expect(mail).to be
      expect(mail.subject).to eq("Your kudo to #{recipient.username} received a thumbs up from #{thumbs_upper.username}")
    end
  end
end
