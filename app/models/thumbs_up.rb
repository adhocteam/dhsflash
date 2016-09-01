class ThumbsUp < ApplicationRecord
  belongs_to :user
  belongs_to :kudo

  validate :only_one_per_user

  protected

  def only_one_per_user
    if ThumbsUp.where(user_id: user_id, kudo_id: kudo_id).where.not(id: id).any?
      errors.add(:user, 'can only give one thumbs up')
    end
  end
end
