require 'rails_helper'

describe 'managing the users as an admin', type: :feature do
  let!(:user) { create(:user) }
  let(:admin) do
    u = create(:user)
    u.add_role(:admin)
    u
  end

  context 'as an admin' do
    before do
      login_as(admin)
    end

    it 'should show the list of users' do
      visit '/admin/users'
      expect(page).to have_content(user.name)
    end

    it 'should let me promote a user to admin' do
      visit '/admin/users'
      within("#user-#{user.id}") do
        click_on('Make admin')
      end
      expect(user.has_role?(:admin)).to be true
    end

    it 'should let me remove their admin rights' do
      user.add_role(:admin)
      visit '/admin/users'
      within("#user-#{user.id}") do
        click_on('Remove admin role')
      end
      expect(user.has_role?(:admin)).to be false
    end

    it 'should let me delete them' do
      visit '/admin/users'
      within("#user-#{user.id}") do
        click_on('Delete user')
      end
      expect(User.where(username: user.username).first).to be_nil
    end
  end

  context 'as a regular user' do
    before do
      login_as user
    end

    it 'should not let me in' do
      visit '/admin/users'
      expect(current_path).to eq('/dashboard')
      expect(page).to have_content('Only admins can view that page')
    end
  end
end
