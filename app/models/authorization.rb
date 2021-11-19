class Authorization < ApplicationRecord
  belongs_to :user

  enum action: {
    index_action: 0,
    show_action: 1,
    new_action: 2,
    edit_action: 3,
    create_action: 4,
    update_action: 5,
    destroy_action: 6
  }

  validates :user_id, presence: true
  validates :action, inclusion: { in: actions.keys }, presence: true
end
