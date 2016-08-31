require 'rails_helper'

describe UsersController, type: :controller do
  context 'search' do
    let!(:user1) { FactoryGirl.create(:user, username: 'andy') }
    let!(:user2) { FactoryGirl.create(:user, username: 'anthony') }
    let!(:user3) { FactoryGirl.create(:user, username: 'anton') }

    before do
      sign_in user1
    end

    it 'should fail when passing no param' do
      get(:search)
      expect(response).to_not be_success
    end

    it 'should return some users' do
      get(:search, params: { search: 'ant' })
      json = JSON.parse(response.body)
      expect(json.map { |i| i['id'] }).to eq([user2.id, user3.id])
    end

    it 'should not return onesself' do
      get(:search, params: { search: 'an' })
      json = JSON.parse(response.body)
      expect(json.map { |i| i['id'] }).to eq([user2.id, user3.id])
    end
  end
end
