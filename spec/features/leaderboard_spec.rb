require 'rails_helper'

describe 'the leaderboard', type: :feature, js: true do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user, username: 'brianeno') }

  let!(:kudo1) { FactoryGirl.create(:kudo, creator: user1, recipient: user2, created_at: 20.days.ago) }
  let!(:kudo2) { FactoryGirl.create(:kudo, creator: user1, recipient: user2, created_at: 18.days.ago) }
  let!(:kudo3) { FactoryGirl.create(:kudo, creator: user1, recipient: user2, created_at: 16.days.ago) }
  let!(:kudo4) { FactoryGirl.create(:kudo, creator: user2, recipient: user1, created_at: 14.days.ago) }
  let!(:kudo5) { FactoryGirl.create(:kudo, creator: user2, recipient: user1, created_at: 12.days.ago) }

  it 'should show received counts on the leaderboard' do
    login_as(user1)
    visit '/dashboard'
    click_on('Received')
    expect(page.find('#leader-tabs-content')).to have_content("#{user1.name} 2")
    expect(page.find('#leader-tabs-content')).to have_content("#{user2.name} 3")
  end

  it 'should show created counts on the leaderboard' do
    login_as(user1)
    visit '/dashboard'
    click_on('Sent')
    expect(page.find('#leader-tabs-content')).to have_content("#{user1.name} 3")
    expect(page.find('#leader-tabs-content')).to have_content("#{user2.name} 2")
  end
end
