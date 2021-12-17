class Authorization < ApplicationRecord
  has_many :user_authorizations
  has_many :users, through: :user_authorizations, dependent: :destroy

  validates :controller, presence: true
  validates :action, presence: true
end
