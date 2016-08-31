require 'rails_helper'

describe ThumbsUp, type: :model do
  context 'validations' do
    let(:user) { FactoryGirl.create(:user) }
    let(:kudo) { FactoryGirl.create(:kudo) }

    it 'should require a user and kudo' do
      tu = ThumbsUp.new
      expect(tu).to_not be_valid
      expect(tu.errors[:user]).to eq(['must exist'])
      expect(tu.errors[:kudo]).to eq(['must exist'])
    end

    it 'should work when given the right stuff' do
      tu = ThumbsUp.new(user: user, kudo: kudo)
      expect(tu).to be_valid
    end
  end
end
