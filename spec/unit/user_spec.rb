require 'rails_helper'

describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  it 'should return a name' do
    expect(user.name).to eq("#{user.first_name} #{user.last_name}")
  end

  it 'should return initials' do
    expect(user.initials).to eq("#{user.first_name[0]}#{user.last_name[0]}".upcase)
  end
end
