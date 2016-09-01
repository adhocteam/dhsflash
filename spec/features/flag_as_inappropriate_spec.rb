require 'rails_helper'

describe 'flagging a kudo as inappropriate', type: :feature, js: true do
  context 'from the dashboard' do
    let(:creator) { FactoryGirl.create(:user, notification_frequency: 'all', notification_method: 'email') }
    let(:recipient) { FactoryGirl.create(:user, notification_frequency: 'all', notification_method: 'email') }
    let(:flagger) { FactoryGirl.create(:user) }
    let!(:kudo) { FactoryGirl.create(:kudo, creator: creator, recipient: recipient) }

    before do
      login_as(flagger)
      visit '/dashboard'
      within("#kudo-#{kudo.id}") do
        page.find('.flag-inappropriate').click
      end
      sleep(1)
      kudo.reload
    end

    it 'should flag the kudo' do
      expect(kudo.inappropriate_count).to eq(1)
    end

    it 'should hide it from now on' do
      visit '/dashboard'
      expect(page).to_not have_content(kudo.message)
    end
  end
end
