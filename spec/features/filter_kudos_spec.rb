require 'rails_helper'

describe 'filtering the kudos', type: :feature, js: true do
  context 'from the dashboard' do
    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    let(:user3) { FactoryGirl.create(:user) }
    let!(:kudo1) { FactoryGirl.create(:kudo, creator: user1, recipient: user2, created_at: 20.days.ago) }
    let!(:kudo2) { FactoryGirl.create(:kudo, creator: user1, recipient: user2, created_at: 18.days.ago) }
    let!(:kudo3) { FactoryGirl.create(:kudo, creator: user2, recipient: user1, created_at: 16.days.ago) }
    let!(:kudo4) { FactoryGirl.create(:kudo, creator: user2, recipient: user1, created_at: 14.days.ago) }

    it 'should have all of the kudos in order of creation' do
      login_as(user1)
      visit '/dashboard'
      things = find_all('.kudo-card')
      expect(things.map { |i| i[:id].sub('kudo-', '').to_i }).to eq([kudo4.id, kudo3.id, kudo2.id, kudo1.id])
    end

    it "should highlight the current user's kudos" do
      login_as(user1)
      visit '/dashboard'
      expect(page).to have_css('.current-user-kudo', count: 2)
    end

    # When I run this spec I get an error about Poltergeist.ObsoleteNode, saying that the content has been
    # replaced. It has been replaced, but isn't it the whole point of these tools that they update based
    # on that?
    it 'should show kudos about me' do
      login_as(user1)
      visit '/dashboard'
      find('#kudo-filter').select('About Me')
      sleep 1
      things = find_all('.kudo-card')
      expect(things.map { |i| i[:id].sub('kudo-', '').to_i }).to eq([kudo4.id, kudo3.id])
    end

    it 'should show ones that i wrote' do
      login_as(user1)
      visit '/dashboard'
      find('#kudo-filter').select('From Me')
      sleep 1
      things = find_all('.kudo-card')
      expect(things.map { |i| i[:id].sub('kudo-', '').to_i }).to eq([kudo2.id, kudo1.id])
    end
  end
end
