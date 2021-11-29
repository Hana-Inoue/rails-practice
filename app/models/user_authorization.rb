class UserAuthorization < ApplicationRecord
  belongs_to :user
  belongs_to :controller_action

  validates :user_id, presence: true
  validates :controller_action_id, presence: true
end
