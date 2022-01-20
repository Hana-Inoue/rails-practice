class Todo < ApplicationRecord
  scope :search, -> (todos_search_params) do
    return if todos_search_params.blank?

    due_date_is(todos_search_params[:due_date])
      .completed_date_is(todos_search_params[:completed_date])
  end
  scope :due_date_is, -> (due_date) { where(due_date: due_date) if due_date.present? }
  scope :completed_date_is, -> (completed_date) do
    where(completed_date: completed_date) if completed_date.present?
  end
end
