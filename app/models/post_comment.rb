class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :user_post

  validates :body, presence: true, length: { maximum: 140 }
end
