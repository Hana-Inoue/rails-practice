class UserPostComment < ApplicationRecord
  belongs_to :user_post

  validates :body, presence: true, length: { maximum: 140 }
  validates :commented_by, presence: true, length: { maximum: 30 }
end
