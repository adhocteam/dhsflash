class ThumbsUp < ApplicationRecord
  belongs_to :user
  belongs_to :kudo
end
