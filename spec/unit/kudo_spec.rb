require 'rails_helper'

describe Kudo, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:recipient) { FactoryGirl.create(:user) }

  context 'validations' do
    it 'should not let me create a kudo for myself' do
      k = Kudo.new(message: 'blat', creator: user, recipient: user)
      expect(k).to_not be_valid
      expect(k.errors[:recipient_id]).to eq(['cannot be the same as the creator'])
    end
  end

  context 'sent and receieved counts' do
    it 'should update its users after create' do
      Kudo.create!(message: 'blat', creator: user, recipient: recipient)
      expect(user.reload.kudos_sent).to eq(1)
      expect(user.reload.kudos_received).to eq(0)

      expect(recipient.reload.kudos_sent).to eq(0)
      expect(recipient.reload.kudos_received).to eq(1)
    end
  end
end
