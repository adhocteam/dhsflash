require 'rails_helper'

describe Kudo, type: :model do
  context 'validations' do
    let(:user) { FactoryGirl.create(:user) }
    let(:recipient) { FactoryGirl.create(:user) }

    it 'should not let me create a kudo for myself' do
      k = Kudo.new(message: 'blat', creator: user, recipient: user)
      expect(k).to_not be_valid
      expect(k.errors[:recipient_id]).to eq(['cannot be the same as the creator'])
    end
  end
end
