class Schedule < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :scheduled_for, presence: true
end
