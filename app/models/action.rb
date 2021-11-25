class Action < ApplicationRecord
  has_many :authorizations
  has_many :users, through: :authorizations, dependent: :destroy

  validates :controller, presence: true
  validates :action, presence: true
end
