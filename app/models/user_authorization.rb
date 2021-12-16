class UserAuthorization < ApplicationRecord
  belongs_to :user
  belongs_to :authorization

  validates :user_id, presence: true
  validates :authorization_id, presence: true
end
