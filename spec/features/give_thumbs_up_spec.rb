require 'rails_helper'

describe 'creating a thumbs up', type: :feature, js: true do
  context 'from the dashboard' do
    let(:creator) { FactoryGirl.create(:user) }
    let(:recipient) { FactoryGirl.create(:user) }
    let(:thumbs_upper) { FactoryGirl.create(:user) }
    let!(:kudo) { FactoryGirl.create(:kudo, creator: creator, recipient: recipient) }

    before do
      login_as(thumbs_upper)
      visit '/dashboard'
      within("#kudo-#{kudo.id}") do
        page.find('.thumbs-up').click
      end
    end

    it 'should create a thumbs up' do
      expect(kudo.thumbs_ups.count).to eq(1)
      expect(kudo.thumbs_ups.first.user).to eq(thumbs_upper)
      expect(kudo.thumbs_ups.first.kudo).to eq(kudo)
    end
  end
end
