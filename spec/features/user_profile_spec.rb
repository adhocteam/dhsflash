require 'rails_helper'

describe 'viewing a user profile', type: :feature, js: true do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user, username: 'brianeno') }
  let!(:user3) { FactoryGirl.create(:user) }

  let!(:kudo1) { FactoryGirl.create(:kudo, creator: user1, recipient: user2) }
  let!(:kudo2) { FactoryGirl.create(:kudo, creator: user1, recipient: user2) }
  let!(:kudo3) { FactoryGirl.create(:kudo, creator: user2, recipient: user1) }
  let!(:kudo4) { FactoryGirl.create(:kudo, creator: user2, recipient: user1) }

  let!(:kudo_unseen) { FactoryGirl.create(:kudo, creator: user3, recipient: user2) }

  let!(:thumbs_up) { ThumbsUp.create(user: user1, kudo: kudo3) }

  before do
    login_as(user1, scope: :user)
  end

  context "viewing their own profile" do
    it 'should show a link to edit profile if the user if viewing their own profile' do
      visit user_path(user1)
      expect(page).to have_content 'Edit your profile'
    end
  end

  context "viewing another user profile" do
    it 'should show a link to edit profile if the user if viewing their own profile' do
      visit user_path(user2)
      expect(page).not_to have_content 'Edit your profile'
    end
  end

  it "should show a list of kudos" do
    visit user_path(user1)
    expect(page).to have_css('.kudo-card', count: 4)
  end

  it "should show the count details for the user" do
    visit user_path(user1)
    expect(page).to have_css('#user-reactions .stat', text: '1')
    expect(page).to have_css('#user-kudos-received .stat', text: '2')
    expect(page).to have_css('#user-kudos-sent .stat', text: '2')
  end
end
