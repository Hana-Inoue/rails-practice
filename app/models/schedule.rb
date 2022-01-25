class Schedule < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :scheduled_for, presence: true
  validates :scheduled_by, presence: true, length: { maximum: 30 }

  scope :search, -> (schedules_search_params) do
    return if schedules_search_params.blank?

    where('name LIKE ?', "#{sanitize_sql_like(schedules_search_params[:name])}") if name.present?
  end
  scope :sql_injection_search, -> (schedules_search_params) do
    return if schedules_search_params.blank?

    where("name LIKE '#{schedules_search_params[:name]}'") if name.present?
  end
end
