class Kudo < ApplicationRecord
  belongs_to :creator, class_name: User
  belongs_to :recipient, class_name: User

  validates :message, presence: true
end
