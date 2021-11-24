class Action < ApplicationRecord
  has_many :authorizations, dependent: :destroy
  has_many :users, through: :authorizations, dependent: :destroy
end
